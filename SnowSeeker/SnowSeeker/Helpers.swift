//
//  Helpers.swift
//  SnowSeeker
//
//  Created by VITALI KAZLOU on 7.10.22.
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

enum SortType {
    case name
    case price
    case country
}
