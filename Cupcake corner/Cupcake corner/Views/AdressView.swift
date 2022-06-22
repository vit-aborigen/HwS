//
//  AdressView.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var order: SharedOrder
    
    var body: some View {
        Form {
            Section {
                TextField("User name", text: $order.data.name)
                
                TextField("Street", text: $order.data.streetAddress)
                
                TextField("City", text: $order.data.city)
                
                TextField("Zip Code", text: $order.data.zip)
            }
            
            Section {
                NavigationLink {
                    CheckOutView(order: order)
                } label: {
                    Text("Proceed to check out")
                }
            }
            .disabled(order.data.hasIncorrectAddress)
        }
        .navigationTitle("Delievery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        AdressView(order: SharedOrder())
    }
}
