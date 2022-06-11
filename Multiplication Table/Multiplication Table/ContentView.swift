//
//  ContentView.swift
//  Multiplication Table
//
//  Created by VITALI KAZLOU on 10.06.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var question = Question()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient (colors: [.mint, .green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Question 1")
                        .font(.title.bold())
                    
                    MathOperatorsView(leftValue: $question.leftDigit, rightValue: $question.rightDigit, mathOpeator: $question.action)
                    
                    Spacer()
                }
            }
            .toolbar {
                Button("Restart") {
                    // 2do some restart stuff later
                }
                .foregroundColor(.black)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
