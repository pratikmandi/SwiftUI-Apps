//
//  ContentView.swift
//  SimpleToDoApp
//
//  Created by Pratik Mandi on 15/12/25.
//

import SwiftUI
import SwiftData

enum FilterOptions: Identifiable, CaseIterable {
    case incomplete
    case completed
    
    var id: FilterOptions {self}
}

extension FilterOptions {
    var title: String {
        switch self{
            case .incomplete:
                return "Incomplete"
            case .completed:
                return "Completed"
        }
    }
}


struct ContentView: View {
    
    @Environment(\.modelContext) private var context //Like database connection to access data
    @State private var title: String = ""
    @Query private var TodoItems: [TodoModel] = [] //Live fetch, if any data is updated, it refetches automatically
    
    @State private var selected: FilterOptions = .incomplete
    
    //Save Todo function
    private func saveTodo(){
        let todoItem = TodoModel(title: title)      //create a model
        
        context.insert(todoItem)        //insert into database
        title = ""
    }
    
    var FilteredTodoItems: [TodoModel] {
        switch selected {
            case .incomplete:
                TodoItems.filter { $0.isCompleted == false }
            case .completed:
                TodoItems.filter { $0.isCompleted == true }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                TextField("Enter Todo", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        saveTodo()
                    }
                
                Picker("Select", selection: $selected) {
                    ForEach(FilterOptions.allCases){ option in
                        Text(option.title)
                            .tag(option)
                    }
                }
                .pickerStyle(.segmented)
                
                List(FilteredTodoItems) { item in
                    HStack{
                        Image(systemName: item.isCompleted ? "checkmark.square" :"square")
                            .onTapGesture {
                                item.isCompleted.toggle()
                            }
                        Text(item.title)
                    }
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
