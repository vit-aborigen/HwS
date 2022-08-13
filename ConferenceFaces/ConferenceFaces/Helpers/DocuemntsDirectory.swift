//
//  DocuemntsDirectory.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 11.08.22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
