//
//  ContentView.swift
//  iExpense
//
//  Created by Pratik Mandi on 20/10/25.
//

import SwiftUI

struct Expense: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
}

/*
 Observable:
 To make @State work with Classes.
 It watches changes in class properties and renders accordingly
 */

@Observable
class Expenses{
    var items = [Expense](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decoded = try? JSONDecoder().decode([Expense].self, from: savedItems){
                items = decoded
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var isShowingSheet = false
    
    //MARK: BODY
    var body: some View {
        NavigationStack{
            List{
                ForEach(expenses.items){item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "INR"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus"){
                        isShowingSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $isShowingSheet) {
                AddExpense(expenses: expenses)
            }
        }
    }
    
    //MARK: FUCNTIONS
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
