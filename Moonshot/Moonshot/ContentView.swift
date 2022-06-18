//
//  ContentView.swift
//  Moonshot
//
//  Created by VITALI KAZLOU on 14.06.22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("ShowGridView") var isDefaultView = true
    
    var body: some View {
        NavigationView {
            Group {
                if isDefaultView {
                    Missions_GridView()
                } else {
                    Missions_ListView()
                }
            }
            .toolbar {
                Toggle("Switch view", isOn: $isDefaultView)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
