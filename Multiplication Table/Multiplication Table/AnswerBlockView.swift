//
//  AnswerBlockView.swift
//  Multiplication Table
//
//  Created by VITALI KAZLOU on 12.06.22.
//

import SwiftUI

struct Card <Back, Front>: View where Back: View, Front: View {
    var back: () -> Back
    var front: () -> Front
    @State private var isFlipped = false
    
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
    }
    
}

struct AnswerBlockView: View {
    @State private var cardFlipAngle = 180.0
    @State private var textFlipAngle = 0.0
    
    var body: some View {
        Text("123")
    }
}
