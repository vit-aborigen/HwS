//
//  AppViewModel.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 16.09.22.
//

import SwiftUI

extension MainView {
    class AppState: ObservableObject {
        @Published var cards = [Card](repeating: Card.test, count: 10)
    }
}
