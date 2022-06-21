//
//  TestClass.swift
//  ViewsAndModifiers
//
//  Created by VITALI KAZLOU on 21.06.22.
//

import Foundation
import SwiftUI

class Test: ObservableObject {
    @Published var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Order: ObservableObject {
    @Published var name: String
    
    init(name: String) {
        self.name = name
    }
}
