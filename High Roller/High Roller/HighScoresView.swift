//
//  HighScoresView.swift
//  High Roller
//
//  Created by VITALI KAZLOU on 30.09.22.
//

import SwiftUI

struct HighScoresView: View {
    @ObservedObject var hsVM = HighScoreVM()
    
    var body: some View {
        ForEach(hsVM.scores) { score in
            SingleScoreView(result: score)
        }
    }
}

struct HighScoresView_Previews: PreviewProvider {
    static var previews: some View {
        HighScoresView()
    }
}
