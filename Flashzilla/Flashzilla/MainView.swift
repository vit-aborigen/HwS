//
//  ContentView.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 12.09.22.
//

import CoreHaptics
import SwiftUI

struct MainView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var diffWithoutColor

    var body: some View {
        HStack {
            if diffWithoutColor {
                Image(systemName: "checkmark.circle")
            }

            Text("Success")
        }
        .padding()
        .background(diffWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
