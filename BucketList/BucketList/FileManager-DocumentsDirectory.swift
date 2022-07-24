//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by VITALI KAZLOU on 24.07.22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
