//
//  Questions.swift
//  Multiplication Table
//
//  Created by VITALI KAZLOU on 10.06.22.
//

import Foundation

enum MathOperator: String, CaseIterable {
    
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "/"
}

class Question: ObservableObject {
    var leftDigit: Int = 2
    var rightDigit: Int = 2
    var action: MathOperator = MathOperator.plus
    
    private func doMath(lhs: Int, rhs: Int) -> Int {
        switch action {
        case .plus:
            return lhs + rhs
        case .minus:
            return lhs - rhs
        case .multiply:
            return lhs * rhs
        case .divide:
            return lhs / rhs
        }
    }
    
    var correctAnswer: Int {
        get {
            return doMath(lhs: leftDigit, rhs: rightDigit)
        }
    }
    
    
    
}
