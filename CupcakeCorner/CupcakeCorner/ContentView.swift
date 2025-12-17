//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Pratik Mandi on 17/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var order = Order()
    
    var body: some View{
        NavigationStack{
            Form{
                Section{
                    Picker("Select Cake Type", selection: $order.type){
                        ForEach(order.types.indices, id: \.self){
                            Text(order.types[$0])
                        }
                    }
                    
                    Stepper("Quantity: \(order.quantity)", value: $order.quantity, in: 1...20)
                }
                
                Section{
                    Toggle("Special Requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add Extra Frosting", isOn: $order.extraFrosting)
                        Toggle("Add Extra Sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section{
                    NavigationLink("Delivery Details"){
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
