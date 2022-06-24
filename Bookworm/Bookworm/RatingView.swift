//
//  RatingView.swift
//  Bookworm
//
//  Created by VITALI KAZLOU on 23.06.22.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var label: String = ""
    
    var body: some View {
        VStack {
            if !label.isEmpty {
                Text(label)
            }
            
            HStack {
                ForEach(1...5, id: \.self) { number in
                    Image(systemName: "star.fill")
                        .scaleEffect(1.3)
                        .padding(15)
                        .onTapGesture {
                            rating = number
                        }
                        .scaleEffect(number == rating ? 1.8 : 1.3)
                        .foregroundColor(number <= rating ? .yellow : .gray)
                        .animation(
                            .linear.delay(Double(number)/10),
                            value: rating)
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
