//
//  AdressView.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("User name", text: $order.name)
                
                TextField("Street", text: $order.streetAddress)
                
                TextField("City", text: $order.city)
                
                TextField("Zip Code", text: $order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckOutView(order: order)
                } label: {
                    Text("Proceed to check out")
                }
            }
            .disabled(order.hasIncorrectAddress)
        }
        .navigationTitle("Delievery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        AdressView(order: Order())
    }
}
