//
//  Missions-ListView.swift
//  Moonshot
//
//  Created by VITALI KAZLOU on 16.06.22.
//

import SwiftUI

struct Missions_ListView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(file: "missions.json")
    
    var body: some View {
        List (missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .padding(.horizontal, 10)
                    
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(mission.formattedDate)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
        .navigationTitle("Moonshot")
        .preferredColorScheme(.dark)
    }
}

struct Missions_ListView_Previews: PreviewProvider {
    static var previews: some View {
        Missions_ListView()
    }
}
