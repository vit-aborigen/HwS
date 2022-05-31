//
//  ButtonsWithImages.swift
//  RPS_simple_game
//
//  Created by VITALI KAZLOU on 31.05.22.
//

import SwiftUI

struct ButtonsWithImages: View {
    var outputImage: String
    
    var body: some View {
        Image(outputImage)
    }
}

struct ButtonsWithImages_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsWithImages()
    }
}
