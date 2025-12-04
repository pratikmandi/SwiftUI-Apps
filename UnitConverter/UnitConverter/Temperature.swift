//
//  Temperature.swift
//  UnitConverter
//
//  Created by Pratik Mandi on 04/09/25.
//

import SwiftUI

struct Temperature: View {
    @State private var inputValue: Double? = nil
    @State private var selectedUnit: String = "Celsius"
    @FocusState private var isFocusState: Bool
    
    let tempUnits: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
    
    // Conversion function
    func convertTemperature(value: Double, from unit: String) -> (c: Double, f: Double, k: Double) {
        switch unit {
        case "Celsius":
            return (value, value * 9/5 + 32, value + 273.15)
        case "Fahrenheit":
            let c = (value - 32) * 5/9
            return (c, value, c + 273.15)
        case "Kelvin":
            let c = value - 273.15
            return (c, c * 9/5 + 32, value)
        default:
            return (0,0,0)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("TEMPERATURE") {
                    TextField("Enter value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocusState)
                    
                    Picker("Select Unit", selection: $selectedUnit) {
                        ForEach(tempUnits, id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                if let value = inputValue {
                    let result = convertTemperature(value: value, from: selectedUnit)
                    
                    Section("Converted Values") {
                        Text("Celsius: \(result.c, specifier: "%.2f") °C")
                        Text("Fahrenheit: \(result.f, specifier: "%.2f") °F")
                        Text("Kelvin: \(result.k, specifier: "%.2f") K")
                    }
                }
            }
//            .navigationTitle("Temperature Converter")
//            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                    Button("Done") {
                        isFocusState = false
                    }
                }
            }
        }
    }

#Preview {
    ContentView()
}
