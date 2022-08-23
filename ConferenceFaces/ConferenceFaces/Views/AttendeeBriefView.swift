//
//  AttendeeBriefView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 18.08.22.
//

import SwiftUI

struct AttendeeBriefView: View {
    var attendee: User
    
    var body: some View {
        HStack {
            Image(uiImage: DataManager.shared.loadPhoto(for: attendee))
                .resizable()
                .scaledToFit()

            Text(attendee.fullName)
                .font(.title2.weight(.semibold))
            
            Spacer()
        }
    }
}

struct AttendeeBriefView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeBriefView(attendee: User(fullName: "test"))
    }
}
