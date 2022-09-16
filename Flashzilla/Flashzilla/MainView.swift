//
//  ContentView.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 12.09.22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var appState = AppState()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    ForEach(0..<appState.cards.count, id: \.self) { offset in
                        CardView(card: appState.cards[offset]) {
                            appState.removeCard(at: offset)
                        }
                            .stacked(at: offset, in: appState.cards.count)
                    }
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
