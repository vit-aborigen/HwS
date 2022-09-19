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

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                Text("Time: \(appState.timeRemaining)")
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
                        .allowsHitTesting(offset == appState.cards.count - 1)
                        .accessibilityHidden(offset < appState.cards.count - 1)
                    }
                }
                .allowsHitTesting(appState.timeRemaining > 0)
                
                if appState.cards.isEmpty {
                    Button("Start Again", action: appState.resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
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
                if !appState.cards.isEmpty {
                    appState.isAppActive = true
                }
            } else {
                appState.isAppActive = false
            }
        })
        .onReceive(timer) { _ in
            guard appState.isAppActive else { return }

            if appState.timeRemaining > 0 {
                appState.decreaseTimer()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
