//
//  ContentView.swift
//  SimpleToDoApp
//
//  Created by Pratik Mandi on 15/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context //Like database connection to access data
    @State private var title: String = ""
    @Query private var TodoItems: [TodoModel] = [] //Live fetch, if any data is updated, it refetches automatically
    
    //Save Todo function
    private func saveTodo(){
        let todoItem = TodoModel(title: title)      //create a model
        
        context.insert(todoItem)        //insert into database
        title = ""
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                TextField("Enter Todo", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        saveTodo()
                    }
                
                List(TodoItems) { item in
                    Text(item.title)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Simple Todo")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoModel.self) //Like a database
}
