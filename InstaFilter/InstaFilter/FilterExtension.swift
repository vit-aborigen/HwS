//
//  FilterExtension.swift
//  InstaFilter
//
//  Created by VITALI KAZLOU on 5.07.22.
//

import Foundation
import CoreImage

extension CIFilter {
    var humanName: String {
        if name.count < 3 { return name}
    
        var splittedName = ""
        for char in name {
            if char.isUppercase {
                splittedName += " "
            }
            splittedName += String(char)
        }
        
        let startIndex = splittedName.index(splittedName.startIndex, offsetBy: 5)
        let withoutCI = String(splittedName[startIndex...])
        return withoutCI
    }
}
