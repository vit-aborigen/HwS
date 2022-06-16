//
//  Divider.swift
//  Moonshot
//
//  Created by VITALI KAZLOU on 16.06.22.
//

import Foundation
import SwiftUI

struct CustomDivider: View {
    let size: CGFloat?
    var body: some View {
        Rectangle()
            .frame(height: size ?? 2.0)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}
