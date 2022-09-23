//
//  ArrayExtension.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 22.09.22.
//

import Foundation

extension Array {
    mutating func moveToTheEnd() {
        let lastElementIdx = self.count - 1
        let element = self[lastElementIdx]
        self.remove(at: lastElementIdx)
        self.insert(element, at: 0)
    }
}
