//
//  MathOpeatorsView.swift
//  Multiplication Table
//
//  Created by VITALI KAZLOU on 10.06.22.
//

import Foundation
import SwiftUI

struct MathOperatorsView: View {
    @State var leftValue: Int = 2
    @State var rightValue: Int = 2
    @State var mathOpeator: String = "+"
    
    var body: some View {
        VStack {
            HStack {
                Picker("Pick Value", selection: $leftValue) {
                    ForEach(1..<11, id: \.self) {
                        Text("\($0)")
                    }
                }
                .improveForMath()
                
                Picker("Math operation", selection: $mathOpeator) {
                    ForEach(MathOperator.allCases, id: \.self) {
                        Text("\($0.rawValue)")
                    }
                }
                .improveForMath()
                
                Picker("Pick Value", selection: $rightValue) {
                    ForEach(1..<11, id: \.self) {
                        Text("\($0)")
                    }
                }
                .improveForMath()
            }
            .scaleEffect(2)
        }
    }
}
