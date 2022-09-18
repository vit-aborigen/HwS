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

    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
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
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
