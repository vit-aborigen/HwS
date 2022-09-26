//
//  ContentView.swift
//  Layout and Geometry
//
//  Created by VITALI KAZLOU on 25.09.22.
//

import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("Live")
                .font(.caption)
                .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
            
            
            Text("long")
            Text("and")
                .font(.title)
                .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
            
            Text("prosper")
                .font(.largeTitle)
        }
        .background(.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
