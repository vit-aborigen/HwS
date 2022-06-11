//
//  Questions.swift
//  Multiplication Table
//
//  Created by VITALI KAZLOU on 10.06.22.
//

import Foundation
import SwiftUI

enum MathOperator: String, CaseIterable {
    
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "/"
}

class Question: ObservableObject {
    @Published var leftDigit: Int = 2
    @Published var rightDigit: Int = 2
    @Published var action: MathOperator = MathOperator.plus
    
    func doMath() -> Int {
        switch self.action {
        case .plus:
            return leftDigit + rightDigit
        case .minus:
            return leftDigit - rightDigit
        case .multiply:
            return leftDigit * rightDigit
        case .divide:
            return leftDigit / rightDigit
        }
    }
    
    var correctAnswer: Int {
        get {
            return doMath()
        }
    }
}
