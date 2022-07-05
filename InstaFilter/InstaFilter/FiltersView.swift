//
//  FiltersView.swift
//  InstaFilter
//
//  Created by VITALI KAZLOU on 4.07.22.
//

import SwiftUI

struct FiltersView: View {
    @State private var filterIntensity: Float = 0.5
    @State private var keys = 0
    
    @ObservedObject var filterList: FiltersList
    
    @State var isSectionOpened = false
    
    var body: some View {
        List {
            ForEach(filterList.filtersInUse, id: \.self) { filter in
                VStack {
                    Section(filter.humanName) {
                        ForEach(filterList.getKeysForFilter(for: filter).keys.sorted(), id: \.self) { key in
                            HStack {
                                Text("\(key)")
                                
                                Slider(value: $filterIntensity)
                            }
                        }
                    }
                }
            }
            .onDelete(perform: deleteSection)
        }
    }
    
    func deleteSection(at: IndexSet) {
        filterList.filtersInUse.remove(atOffsets: at)
    }
}
