//
//  ContentView.swift
//  UnitConverter
//
//  Created by Pratik Mandi on 04/09/25.
//

import SwiftUI

struct ContentView: View {
    let categories = ["Temperature", "Length", "Weight", "Speed", "Volume", "Area"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(categories, id: \.self) { category in
                        NavigationLink {
                            if category == "Temperature" {
                                Temperature()
                            } else {
                                Text("\(category) Converter Coming Soon")
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.secondary.opacity(0.16))
                                    .frame(height: 100)
                                    .shadow(radius: 10)
                                
                                Text(category)
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Unit Converter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
