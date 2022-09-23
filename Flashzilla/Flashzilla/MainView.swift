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
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

    @Environment(\.scenePhase) var scenePhase

    @State private var showEditScreen = false

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
                    ForEach(appState.cards, id: \.self) { card in
                        let offset = appState.cards.firstIndex(of: card) ?? 0
                        CardView(card: appState.cards[offset]) { reprocess in
                            appState.removeCard(at: offset, reprocessLater: reprocess)
                        }
                        .stacked(at: offset, in: appState.cards.count)
                        .allowsHitTesting(offset == appState.cards.count - 1)
                        .accessibilityHidden(offset < appState.cards.count - 1)
                    }
                }
                .allowsHitTesting(appState.timeRemaining > 0)

                if appState.cards.isEmpty {
                    Button {
                        appState.resetCards()

                    } label: {
                        Text("Start again")
                    }
                    .padding()
                    .background(.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                }
            }

            VStack {
                HStack {
                    Spacer()

                    Button {
                        showEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()

            if diffWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                appState.removeCard(at: appState.cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark answer as incorrect")

                        Spacer()

                        Button {
                            withAnimation {
                                appState.removeCard(at: appState.cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark answer as correct")
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
        .onAppear {
            DispatchQueue.main.async {
                appState.loadData()
            }
        }
        .sheet(isPresented: $showEditScreen) {
            EditCardsView(cards: appState.cards) { newCards in
                appState.addCards(newCards: newCards)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
