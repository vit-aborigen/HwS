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
            VStack {
                Text(conf.name)
                    .font(.headline).bold()
                
                Text(conf.place)
            }
            
            Text(conf.date.formatted(date: .long, time: .omitted))
            
            Spacer()
            
            Text("\(conf.attendees.count)")
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .onTapGesture {
            showDetails = true
        }
        .sheet(isPresented: $showDetails) {
            ConferenceFullView()
        }
    }
}

struct ConferenceBriefView_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceBriefView(conf: Conference.example)
    }
}
