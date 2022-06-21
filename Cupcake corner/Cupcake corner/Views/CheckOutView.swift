//
//  CheckOutView.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    
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
                
            Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                .font(.title)
            
            Button {
                //
            } label: {
                Text("Place order")
            }
            .padding()
            
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
