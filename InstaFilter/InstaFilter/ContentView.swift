//
//  ContentView.swift
//  InstaFilter
//
//  Created by VITALI KAZLOU on 1.07.22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var filterIntensity: Float = 0.5
    @State private var isImagePickerShown = false
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
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
                    isImagePickerShown = true
                }
                
                
                HStack {
                    Text("Intensity")
                    
                    Slider(value: $filterIntensity)
                        .padding(.vertical)
                        .onChange(of: filterIntensity) { _ in
                            applyProcessing()
                        }
                }
                
                HStack {
                    Button("Change filter") {
                        // 2do: filter selection
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(imageIsLoaded())
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .onChange(of: inputImage) { _ in loadImage()}
            .sheet(isPresented: $isImagePickerShown) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save() {
        // 2do: save to the gallery
    }
    
    func applyProcessing() {
        currentFilter.intensity = filterIntensity
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
    func imageIsLoaded() -> Bool {
        if let image = image {
            return false
        }
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

