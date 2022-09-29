//
//  ContentView.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 28.09.22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        HStack {
            DiceView(dice: Dice(sides: 556))
            DiceView(dice: Dice(sides: 25423456))
            DiceView(dice: Dice(sides: 62345234))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
