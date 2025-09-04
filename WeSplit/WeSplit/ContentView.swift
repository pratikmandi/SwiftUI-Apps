//
//  ContentView.swift
//  WeSplit
//
//  Created by Pratik Mandi on 03/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 20
    @FocusState private var isFocusState: Bool
    
    let tips = [0,10,15,20,25]
    
    var splitAmount: Double {
        let tipAmount = (checkAmount * Double(tipPercentage)) / 100
        return (checkAmount + tipAmount) / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(code: Locale.current.currency?.identifier ?? "INR")
                    )
                    .keyboardType(.decimalPad)
                    .focused($isFocusState)
                    
                    Picker("Number of people:", selection: $numberOfPeople) {
                        ForEach(1..<11) { value in
                            Text("\(value)").tag(value)
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip Percentage:", selection: $tipPercentage) {
                        ForEach(tips, id: \.self) { p in
                            Text(p, format: .percent).tag(p)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total Amount") {
                    let total = checkAmount + (checkAmount * Double(tipPercentage) / 100)
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                }
                
                Section("Split Amount") {
                    Text(splitAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                }
            }
            .navigationTitle("WeSplit")
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                if isFocusState{
                    Button("Done") {
                        isFocusState = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
