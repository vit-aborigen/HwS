//
//  ProspectsViewModel.swift
//  Hot Prospects
//
//  Created by VITALI KAZLOU on 6.09.22.
//

import SwiftUI

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        people = []
    }
}
