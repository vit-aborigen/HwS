//
//  ContentView.swift
//  SnowSeeker
//
//  Created by VITALI KAZLOU on 2.10.22.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct MainView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    
    @State private var searchText = ""
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        }
        return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
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
