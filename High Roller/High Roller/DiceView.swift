//
//  DiceView.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 29.09.22.
//

import SwiftUI

struct DiceView: View {
    var body: some View {
        Text("42")
            .font(.headline.weight(Font.Weight.heavy))
            .padding()
            .background(.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .pink, radius: 4, x: 3, y: 3)
            .padding(5)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
