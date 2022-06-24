//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by VITALI KAZLOU on 24.06.22.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16
    
    var body: some View {
        Image(systemName: "\(rating).circle.fill")
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: Int16(3))
    }
}
