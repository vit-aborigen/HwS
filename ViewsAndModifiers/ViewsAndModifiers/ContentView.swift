//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by VITALI KAZLOU on 29.05.22.
//

import SwiftUI

struct ContentView: View {
    let image = UIImage(systemName: "questionmark.circle")!

    var body: some View {
        Image(uiImage: image)
            .onTapGesture {
                let savePath = FileManager.documentsDirectory
                
                if let data = image.jpegData(compressionQuality: 0.8) {
                    let filename = savePath.appendingPathComponent("MyConferences\newImage.jpg")
                    do {
                        try data.write(to: filename)
                    } catch {
                        print("Failed to save image: \(error.localizedDescription)")
                    }
                }
            }
    }
}


extension FileManager {
    static var documentsDirectory: URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
