//
//  SingleScoreView.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 30.09.22.
//

import SwiftUI

struct SingleScoreView: View {
    let result: Score
    
    var body: some View {
        HStack(spacing: 10) {
            Text("\(result.score)")
                .font(.title)
                .padding(15)
                .background(.red)
                .foregroundColor(.white)
                .clipShape(Circle())
            
            Spacer()
            
            VStack {
                Text(result.time, style: .date)
                Text("Configuration: " + result.snapshotString)
                    .font(.subheadline)
            }
            
            Spacer()
                
            VStack {
                Text("\(result.numberOfDices)D")
                Text("\(result.numberOfSides)S")
            }
            .font(.headline)
        }
    }
}

struct SingleScoreView_Previews: PreviewProvider {
    static var previews: some View {
        SingleScoreView(result: Score.example)
    }
}
