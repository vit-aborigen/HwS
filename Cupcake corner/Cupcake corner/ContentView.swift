//
//  ContentView.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                MainOrderView(order: order)
                
                DelieveryDetailsBlockView(order: order)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
