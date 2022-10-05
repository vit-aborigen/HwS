//
//  ResortView.swift
//  SnowSeeker
//
//  Created by VITALI KAZLOU on 3.10.22.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    @EnvironmentObject var favorites: Favorites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text("by " + resort.imageCredit)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack {
                if sizeClass == .compact && typeSize > .large {
                    VStack(spacing: 10) {
                        ResortDetailsView(resort: resort)
                    }
                    VStack(spacing: 10) {
                        SkiDetailsView(resort: resort)
                    }
                } else {
                    ResortDetailsView(resort: resort)
                    SkiDetailsView(resort: resort)
                }
            }
            .padding(.vertical)
            .background(.primary.opacity(0.1))
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            
            Group {
                Text(resort.description)
                    .padding(.vertical)
                
                Text("Facilities")
                    .font(.headline)
                
                HStack {
                    ForEach(resort.facilityImage) { facility in
                        Button {
                            selectedFacility = facility
                            showingFacility = true
                        } label: {
                            facility.icon
                                .font(.title)
                        }
                    }
                }
                .padding(.vertical)
                
                Button(favorites.contains(resort) ? "Remove favorites" : "Add to favorites") {
                    if favorites.contains(resort) {
                        favorites.delete(resort)
                    } else {
                        favorites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding(.horizontal)
        }
        .navigationTitle(resort.name + ", " + resort.country)
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "?", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
            .environmentObject(Favorites())
    }
}
