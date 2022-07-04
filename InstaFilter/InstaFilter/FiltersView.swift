//
//  FiltersView.swift
//  InstaFilter
//
//  Created by VITALI KAZLOU on 4.07.22.
//

import SwiftUI

struct FiltersView: View {
    @State private var filterIntensity: Float = 0.5
    @ObservedObject var filterList: FiltersList
    
    @State var isSectionOpened = false
    
    var body: some View {
        List {
            ForEach(filterList.filtersInUse, id: \.self) { filter in
                VStack {
                    Section(filter.humanName) {
                        ForEach(filterList.getKeysForFilter(for: filter), id: \.self) { key in
                            HStack {
                                Text(key)
                                
                                Slider(value: $filterIntensity)
                            }
                        }
                    }
                    .alignmentGuide(.trailing, computeValue: {_ in 100.0 })
                }
            }
            .onDelete { _ in }
        }
    }
    
    func deleteSection(at: IndexSet) {
        
    }
}
