//
//  AstronautView.swift
//  Moonshot
//
//  Created by VITALI KAZLOU on 16.06.22.
//

import SwiftUI

struct AstronautView: View {
    let astonaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(decorative: astonaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astonaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astonaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")

    static var previews: some View {
        AstronautView(astonaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
    }
}
