//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Pratik Mandi on 18/12/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
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

                Button("Place Order", action: {
                    Task{
                        await placeOrder()
                    }
                })
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encodedData = try? JSONEncoder().encode(order) else {
            confirmationMessage = "Failed to encode order."
            showingConfirmation = true
            return
        }

        let url = URL(string: "https://httpbin.org/post")! //mock-free POST api endpoint
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: encodedData)
            
            if let jsonObject = try? JSONSerialization.jsonObject(with: data),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print(prettyString)
            }

            if let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) {

                confirmationMessage =
                "Your order for \(order.quantity) \(order.types[order.type].lowercased()) cupcakes is on its way!"
            } else {
                confirmationMessage = "Order failed. Please try again."
            }

            showingConfirmation = true
        } catch {
            confirmationMessage = "Checkout failed: \(error.localizedDescription)"
            showingConfirmation = true
        }
    }
}

#Preview {
    NavigationStack{
        CheckoutView(order: Order())
    }
}
