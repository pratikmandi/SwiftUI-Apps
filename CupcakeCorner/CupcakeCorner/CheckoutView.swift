//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Pratik Mandi on 18/12/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { phase in
                    if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Text("There was an error loading the image.")
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(height: 233)
                
                Text("Your total is \(order.price, format: .currency(code: "INR"))")
                    .font(.title)

                Button("Place Order", action: { })
                    .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    NavigationStack{
        CheckoutView(order: Order())
    }
}
