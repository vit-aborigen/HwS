//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by VITALI KAZLOU on 3.10.22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)

            Text("Please select a resort from the menu")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
