//
//  FiltersList.swift
//  InstaFilter
//
//  Created by VITALI KAZLOU on 4.07.22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation

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

class FiltersList: Identifiable, ObservableObject {
    private var allFilters: Set<CIFilter> = [.sepiaTone(), .crystallize(), .glassDistortion(), .edges(), .gaussianBlur(), .vignette(), .vibrance(), .pointillize(), .bloom(), .photoEffectNoir()]
    
    @Published var filtersInUse = Array<CIFilter> ()
    
    public func availableFilters() -> Array<CIFilter> {
        allFilters.filter { !filtersInUse.contains($0) }
    }
    
    public func getKeysForFilter(for filter: CIFilter) -> [String] {
        var allKeys = filter.inputKeys
        if allKeys.contains("inputImage") {
            allKeys.remove(at: 0)
        }
        return allKeys
    }
    
}
