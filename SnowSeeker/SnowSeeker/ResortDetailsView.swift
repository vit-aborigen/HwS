//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by VITALI KAZLOU on 3.10.22.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort

    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                Text(resort.sizeString)
                    .font(.title3)
            }

            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(resort.priceString)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
