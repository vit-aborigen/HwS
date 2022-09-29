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
            DiceView()
            DiceView()
            DiceView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
