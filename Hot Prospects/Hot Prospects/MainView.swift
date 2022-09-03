//
//  ContentView.swift
//  Hot Prospects
//
//  Created by VITALI KAZLOU on 1.09.22.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 2
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("1")
                .tabItem {
                    Label("One", systemImage: "1.circle")
                }
                .tag(1)
            
            Text("2")
                .tabItem {
                    Label("Two", systemImage: "2.circle")
                }
                .tag(2)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
