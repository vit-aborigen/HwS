//
//  ContentView.swift
//  InstaFilter
//
//  Created by VITALI KAZLOU on 1.07.22.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select image")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    // 2do: load image
                }
                
                HStack {
                    Text("Intensity")
                    
                    Slider(value: $filterIntensity)
                        .padding(.vertical)
                }
                
                HStack {
                    Button("Change filter") {
                        // 2do: filter selection
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
        }
    }
    
    func save() {
        // 2do: save to the gallery
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

