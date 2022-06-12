//
//  AnswerBlockView.swift
//  Multiplication Table
//
//  Created by VITALI KAZLOU on 12.06.22.
//

import SwiftUI

struct Card <Back, Front>: View where Back: View, Front: View {
    @State var isFlipped = false
    @State private var rotationAngle = 0.0
    
    var back: () -> Back
    var front: () -> Front
    
    init (@ViewBuilder back: @escaping () -> Back, @ViewBuilder front: @escaping () -> Front) {
        self.front = front
        self.back = back
    }
    
    var body: some View {
        ZStack {
            if isFlipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(Angle(degrees: -rotationAngle), axis: (x: 0, y: 1, z: 0))
        .font(.title.bold())
        .frame(width: 300, height: 200)
        .background(LinearGradient(colors: [.red, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
        .overlay (
            Rectangle()
                .stroke(.black, lineWidth: 2))
        .onTapGesture {
            flipCard()
        }
        .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 0, y: 1, z: 0))
    }
    
    func flipCard() {
        withAnimation {
            rotationAngle += 180.0
            isFlipped.toggle()
        }
    }
}

struct CardView: View {
    @State private var isFlipped = false
    var correctAnswer: Int
    
    var body: some View {
        VStack {
            Card(back: {
                Text("Correct answer is \(correctAnswer)")
            }, front: {
                Text("Reveal answer")
            })
        }
    }

}

struct Cardiew_Previews: PreviewProvider {
    static var previews: some View {
        CardView(correctAnswer: 42)
    }
}
