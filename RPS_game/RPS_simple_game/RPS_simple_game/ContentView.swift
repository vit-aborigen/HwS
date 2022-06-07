//
//  ContentView.swift
//  RPS_simple_game
//
//  Created by VITALI KAZLOU on 31.05.22.
//

import SwiftUI

struct ImagesForButtons: View {
    var gesture: String
    
    var body: some View {
        Image(gesture)
    }
}



struct ContentView: View {
    @StateObject var gameHelper = Helper(amountOfTurns: 10)
    
    let winners = ["Rock": "Scissors" , "Paper": "Rock", "Scissors": "Paper"]
    let figures = ["Rock", "Paper", "Scissors"]
    
    @State private var currentTurn: Int = 0
    @State private var score: Int = 0
    @State private var userChoise: Int = -1
    @State private var result = false
    @State private var animatedGradient = false
    @State private var gameIsOver = false
    
    @State var gameResult: PossibleOutput = PossibleOutput.allCases.randomElement()!
    @State var opponent: Int = Int.random(in: 0..<3)
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .yellow], startPoint: animatedGradient ? .topLeading : .bottomLeading, endPoint: animatedGradient ? .bottomTrailing : .topTrailing)
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: 20.0).repeatForever(autoreverses: true)) {
                        animatedGradient.toggle()
                    }
                }
            
            VStack {
                
                Spacer()
                
                Section {
                    Text("You should")
                        .font(.largeTitle)
                    Text(gameResult.rawValue)
                        .font(.largeTitle.bold())
                    Text("vs")
                    Image(figures[opponent])
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                
                Spacer()
                
                HStack {
                    ForEach (0..<3) { number in
                        Button {
                            result = proceedUserPick(userPicked: number)
                            gameResult = PossibleOutput.allCases.randomElement()!
                            opponent = Int.random(in: 0..<3)
                        } label: {
                            Image(figures[number])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .padding()
                
                Spacer()
                Spacer()
                
                HStack {
                    Text("Your score is ")
                    Text("\(score)")
                        .font(.largeTitle.bold())
                    Text(" points")
                }
                .font(.largeTitle)
                
                HStack {
                    Text("\(gameHelper.maxTurns - currentTurn)")
                        .font(.largeTitle.bold())
                    Text(" turns left")
                        .font(.largeTitle)
                }
            }
            .alert("Game is over", isPresented: $gameIsOver) {
                Button("Restart", action: restartGame)
            } message: {
                Text("You finished with \(score) points")
            }
            
        }
    }
    
    func restartGame() {
        currentTurn = 0
        score = 0
        gameIsOver = false
        gameResult = PossibleOutput.allCases.randomElement()!
        opponent = Int.random(in: 0..<3)
    }
    
    func proceedUserPick(userPicked number: Int) -> Bool {
        currentTurn += 1
        
        if currentTurn == gameHelper.maxTurns {
            gameIsOver = true
        }
        
        let userPick = figures[number]
        let choiseToWin = winners[figures[opponent]]
        let desiredOutcome = gameResult.rawValue
        
        if (desiredOutcome == "Win") && (userPick != choiseToWin) && (userPick != figures[opponent])  {
            score += 1
            return true
        }
        if (desiredOutcome == "Lose") && (userPick == choiseToWin) {
            score += 1
            return true
        }
        
        if score > 0 { score -= 1}
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
