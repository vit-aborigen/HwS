//
//  DiceView.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 29.09.22.
//

import SwiftUI

struct DiceView: View {
    let dice: Dice
    let text = "123"
    
    var body: some View {
        Text(text)
            .font(.headline.weight(Font.Weight.heavy))
            .padding()
            .frame(width: 75, height: 75)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .pink, radius: 4, x: 3, y: 3)
            .padding(10)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(dice: Dice.example)
    }
}
