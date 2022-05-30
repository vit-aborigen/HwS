//
//  ContentView.swift
//  Guess the Flag
//
//  Created by VITALI KAZLOU on 26.05.22.
//

import SwiftUI

struct MakeHeaderLargeAndWhite: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

extension View {
    func increaseHeader() -> some View {
        modifier(MakeHeaderLargeAndWhite)
    }
}

struct FlagImage: View {
    var countryName: String
    
    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule(style: .continuous))
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    
    @State private var currentTurn = 0
    private var maxTurns = 10
    @State private var gameIsOver = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
           RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                                   .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()

            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .increaseHeader()
                
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countryName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Text("Your score is \(score)")
                    .increaseHeader()
                
                Text("Turns left \(maxTurns - currentTurn)")
                    .increaseHeader()
                
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button ("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert("Game is over", isPresented: $gameIsOver) {
            Button ("Restart", action: startNewGame)
        } message: {
            Text("You finished with \(score) points")
        }
    }
        
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong. That's the flag of \(countries[number])"
            score -= 1
        }
        currentTurn += 1
        
        if currentTurn == maxTurns {
            gameIsOver = true
        } else {
            showingScore = true
            
        }
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func startNewGame() {
        score = 0
        currentTurn = 0
        gameIsOver = false
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
