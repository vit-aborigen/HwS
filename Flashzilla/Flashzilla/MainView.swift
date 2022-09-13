//
//  ContentView.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 12.09.22.
//

import CoreHaptics
import SwiftUI

struct MainView: View {
    @State private var text = ""
    @Environment(\.scenePhase) var scenePhase
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(text)
            .onReceive(timer) { time in
                text = time.description
            }
            .onChange(of: scenePhase) { newScenePhase in
                switch newScenePhase {
                case .active:
                    print("Active")
                case .background:
                    print("Background")
                case .inactive:
                    print("Inactive")
                @unknown default:
                    print("Unknown")
                }
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
