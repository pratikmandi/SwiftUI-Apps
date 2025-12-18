//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Pratik Mandi on 17/12/25.
//

import Foundation
import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Post Code", text: $order.postCode)
            }
            
            Section{
                NavigationLink("Checkout"){
                    CheckoutView(order: order)
                }
            }.disabled(order.isValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        AddressView(order: Order())
    }
}
