//
//  CheckOutView.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: SharedOrder
    @State private var confirmationMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3.0) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 233)
                
            Text("Your total is \(order.data.cost, format: .currency(code: "USD"))")
                .font(.title)
            
            Button {
                Task {
                    await placeOrder()
                }
            } label: {
                Text("Place order")
            }
            .padding()
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert ("Order #xxxx", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.data) else {
            confirmationMessage = "Failed to encode order"
            showAlert = true
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order of \(decodedOrder.quantity)x \(decodedOrder.type.rawValue) is on the way"
            showAlert = true
        } catch {
            confirmationMessage = "Checkout failed"
            showAlert = true
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: SharedOrder())
    }
}
