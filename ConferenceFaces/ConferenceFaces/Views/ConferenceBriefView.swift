//
//  ConferenceBriefView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 11.08.22.
//

import SwiftUI

struct ConferenceBriefView: View {
    @State private var showDetails = false
    var conf: Conference
    
    var body: some View {
        HStack {
            Text(conf.place)
            
            Text(conf.date.formatted(date: .long, time: .omitted))
            
            Text(conf.name)
            
            Text("Full info")
                .foregroundColor(.blue)
                .onTapGesture {
                    showDetails = true
                }
                .sheet(isPresented: $showDetails) {
                    ConferenceFullView()
                }
        }
    }
}

struct ConferenceBriefView_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceBriefView(conf: Conference.example)
    }
}
