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

struct MarkIncorrectFlags: ViewModifier {
    func body(content: Content) -> some View {
        content
            .opacity(0.25)
            .scaleEffect(0.6)
    }
}

struct MarkCorrectFlag: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaleEffect(1.5)
            .rotation3DEffect(Angle(degrees: 360.0), axis: (x: 0, y: 1, z: 0))
    }
}

extension View {
    func increaseHeader() -> some View {
        modifier(MakeHeaderLargeAndWhite())
    }
    
    func shrinkFlag() -> some View {
        modifier(MarkIncorrectFlags())
    }
    
    func correctAnswer() -> some View {
        modifier(MarkCorrectFlag())
    }
}


struct FlagImage: View {
    var countryName: String
    
    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule(style: .continuous))
            .shadow(radius: 5)    }
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
    @State private var userFlag = -1
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
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
                    
                    ForEach(0..<3, id: \.self) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countryName: countries[number])
                                .accessibilityLabel(labels[countries[number]] ?? "UK")
                                .rotation3DEffect(Angle(degrees: userFlag == number ? 360.0 : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(userFlag == -1 || userFlag == number ? 1 : 0.25)
                                .animation(.interpolatingSpring(stiffness: 25, damping: 40), value: userFlag)
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
        userFlag = number
        
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
        userFlag = -1
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
