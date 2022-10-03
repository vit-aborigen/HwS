//
//  ResortView.swift
//  SnowSeeker
//
//  Created by VITALI KAZLOU on 3.10.22.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                ZStack(alignment: .bottomTrailing) {
                    Image(resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text(resort.imageCredit)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack {
                ResortDetailsView(resort: resort)
                SkiDetailsView(resort: resort)
            }
            .padding(.vertical)
            .background(.primary.opacity(0.1))
            
            Group {
                Text(resort.description)
                    .padding(.vertical)
                
                Text("Facilities")
                    .font(.headline)
                
                Text(resort.facilities, format: .list(type: .and))
                    .padding(.vertical)
            }
            .padding(.horizontal)
        }
        .navigationTitle(resort.name + ", " + resort.country)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
