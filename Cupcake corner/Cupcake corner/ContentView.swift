//
//  ContentView.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = SharedOrder()
    
    var body: some View {
        NavigationView {
            Form {
                MainOrderView(order: order)
                
                DelieveryDetailsBlockView(order: order)
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
