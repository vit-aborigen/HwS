//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by VITALI KAZLOU on 29.05.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var testClass = Test(name: "")
    @StateObject var myOrder: Order?

    var body: some View {
        NavigationView {
            Form {
                NavigationLink {
                    NameView(testClass: testClass)
                } label: {
                    Text("Proceed to \(testClass.name)")
            }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
