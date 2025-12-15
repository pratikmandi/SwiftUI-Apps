//
//  SimpleToDoAppApp.swift
//  SimpleToDoApp
//
//  Created by Pratik Mandi on 15/12/25.
//

import SwiftUI
import SwiftData

@main
struct SimpleToDoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: TodoModel.self)
        }
    }
}
