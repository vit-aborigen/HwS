//
//  ContentView.swift
//  Hot Prospects
//
//  Created by VITALI KAZLOU on 1.09.22.
//

import SwiftUI

struct MainView: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello")
                .padding()
                .background(backgroundColor)
            
            Text("Change color")
                .padding()
                .contextMenu {
                    Button(role: .destructive) {
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                    }
                    
                    Button {
                        backgroundColor = .yellow
                    } label: {
                        Label("Yellow", systemImage: "checkmark.circle.fill")
                    }
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
