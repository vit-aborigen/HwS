//
//  ContentView.swift
//  SnowSeeker
//
//  Created by VITALI KAZLOU on 2.10.22.
//

import SwiftUI

struct MainView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    
    @State private var searchText = ""
    @State private var sortingType = SortType.name
    @State private var showContextMenu = false
    
    var sortedResorts: [Resort] {
        switch sortingType {
        case .name:
            return filteredResorts.sorted { $0.name < $1.name }
        case .price:
            return filteredResorts.sorted { $0.price < $1.price }
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        }
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        }
        return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(Capsule())
                        .overlay {
                            Capsule()
                                .stroke(.black, lineWidth: 1)
                        }
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    
                    if favorites.contains(resort) {
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .font(.headline)
                            .symbolRenderingMode(.palette)
                            .foregroundColor(.red)
                            .accessibilityLabel("This is a favorite resort")
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Resorts")
            .toolbar {
                Button {
                    showContextMenu = true
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .confirmationDialog("Choose a filter", isPresented: $showContextMenu) {
                Button("By name") { sortingType = .name }
                Button("By price") { sortingType = .price}
                Button("By country") { sortingType = .country}
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
