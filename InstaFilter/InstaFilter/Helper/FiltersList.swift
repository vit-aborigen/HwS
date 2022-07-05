//
//  FiltersList.swift
//  InstaFilter
//
//  Created by VITALI KAZLOU on 4.07.22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation

enum FilterKeys: String {
    case kCIInputIntensityKey = "Intensity"
    case kCIInputRadiusKey = "Radius"
    case kCIInputScaleKey = "Scale"
}

class FiltersList: Identifiable, ObservableObject {
    private var allFilters: Set<CIFilter> = [.sepiaTone(), .crystallize(), .glassDistortion(), .edges(), .gaussianBlur(), .vignette(), .vibrance(), .pointillize(), .bloom(), .photoEffectNoir()]
    
    @Published var filtersInUse = Array<CIFilter> ()
    
    public func availableFilters() -> Array<CIFilter> {
        allFilters.filter { !filtersInUse.contains($0) }
    }
    
    public func getKeysForFilter(for filter: CIFilter) -> [String: String] {
        var filtersWithName = Dictionary<String, String> ()
        
        for key in filter.inputKeys {
            if key.contains(kCIInputIntensityKey) {
                filtersWithName[key] = "Intensity"
            }
            
            if key.contains(kCIInputRadiusKey) {
                filtersWithName[key] = "Radius"
            }
            
            if key.contains(kCIInputScaleKey) {
                filtersWithName[key] = "Scale"
            }
        }
        
        return filtersWithName
    }
    
}
