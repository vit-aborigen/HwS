//
//  MeView.swift
//  Hot Prospects
//
//  Created by VITALI KAZLOU on 6.09.22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Please enter your name"
    @State private var email = "test@gmail.com"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .font(.title)
                    .textContentType(.name)
                
                TextField("Email", text: $email)
                    .font(.title)
                    .textContentType(.emailAddress)
                
                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save to photos", systemImage: "square.and.arrow.down")
                        }
                    }
                    .onChange(of: name) { _ in updateQRCode() }
                    .onChange(of: email) { _ in updateQRCode() }
                    .onAppear { updateQRCode() }
            }
            .navigationTitle("Your code")
        }
    }
    
    func updateQRCode() {
        qrCode = generateQRCode(from: "\(name)\n\(email)")
    }
    
    func generateQRCode(from str: String) -> UIImage {
        filter.message = Data(str.utf8)
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
