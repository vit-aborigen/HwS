//
//  ContentView.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 28.09.22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var appState = AppState()

    @State private var numberOfDices = 1
    @State private var numberOfSides = 6

    var body: some View {
        NavigationView {
            VStack {
                Stepper("Number of dices: \(numberOfDices)", value: $numberOfDices, in: 1...20)
                Stepper("Number of sides: \(numberOfSides)", value: $numberOfSides, in: 1...20)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(appState.dices, id: \.id) { dice in
                            DiceView(dice: dice)
                        }
                    }
                }

                VStack {
                    //Text("Your score is \(appState.returnSum())")
                    //    .font(.headline)
                    
                    Text("High Score is")
                }
                

                Spacer()

                Button("Reroll") {
                    appState.reroll(dices: numberOfDices, sides: numberOfSides)
                }
                .padding(10)
                .background(.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .toolbar {
                Button {} label: {
                    Text("High scores")
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
