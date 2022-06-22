//
//  DelieveryDetailsBlockView.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import SwiftUI

struct DelieveryDetailsBlockView: View {
    @ObservedObject var order: SharedOrder
    
    var body: some View {
        Section {
            NavigationLink {
                AdressView(order: order)
            } label: {
                Text("Delievery details")
            }
        }
    }
}

struct DelieveryDetailsBlockView_Previews: PreviewProvider {
    static var previews: some View {
        DelieveryDetailsBlockView(order: SharedOrder())
    }
}
