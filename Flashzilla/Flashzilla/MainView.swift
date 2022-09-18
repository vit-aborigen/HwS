//
//  ContentView.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 12.09.22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var appState = AppState()
    @Environment(\.accessibilityDifferentiateWithoutColor) var diffWithoutColor
    @Environment(\.scenePhase) var scenePhase
    
    @State private var isAppActive = true
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                
                
                ZStack {
                    ForEach(0 ..< appState.cards.count, id: \.self) { offset in
                        CardView(card: appState.cards[offset]) {
                            appState.removeCard(at: offset)
                        }
                        .stacked(at: offset, in: appState.cards.count)
                    }
                }
            }

            if diffWithoutColor {
                VStack {
                    Spacer()

                    HStack {
                        Image(systemName: "xmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onChange(of: scenePhase, perform: { newValue in
            if newValue == .active {
                isAppActive = true
            } else {
                isAppActive = false
            }
        })
        .onReceive(timer) { time in
            guard isAppActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
