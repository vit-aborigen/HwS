//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by VITALI KAZLOU on 29.05.22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("age") private var age = 30

    var body: some View {
        Button("Age now is \(age)") {
            age += 1
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
