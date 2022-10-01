//
//  ContentView.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 28.09.22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var appState = AppState()
    @ObservedObject var hsVM = HighScoreVM()

    @State private var numberOfDices = 1
    @State private var numberOfSides = 6

    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timerTick = 6
    let maxDiceFlicksPossible = 5

    let columns = [GridItem(.adaptive(minimum: 75))]

    var body: some View {
        NavigationView {
            VStack {
                Stepper("Number of dices: \(numberOfDices)", value: $numberOfDices, in: 1...20)
                Stepper("Number of sides: \(numberOfSides)", value: $numberOfSides, in: 1...20)

                Text("Your score is \(appState.score)")
                    .font(.headline)

                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(appState.dices, id: \.id) { dice in
                            DiceView(dice: dice)
                        }
                    }
                }

                Spacer()

                Button("Reroll") {
                    self.timerTick = 1
                    self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
                }
                .padding(10)
                .background(.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .onReceive(timer) { _ in
                print(timerTick, maxDiceFlicksPossible)
                if timerTick <= maxDiceFlicksPossible {
                    appState.reroll(dices: numberOfDices, sides: numberOfSides)
                    timerTick += 1
                } else {
                    self.timer.upstream.connect().cancel()
                    hsVM.checkScores(newScore: appState.returnScore())
                }
            }
            .toolbar {
                Button {} label: {
                    NavigationLink("High Scores", destination: HighScoresView(hsVM: hsVM))
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
