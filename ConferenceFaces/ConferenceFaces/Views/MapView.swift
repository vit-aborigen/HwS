//
//  MapView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 30.08.22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var mapVM = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $mapVM.mapRegion, annotationItems: [Location.example]) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Image(systemName: "star.circle")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 44, height: 44)
                    .background(.white)
                    .clipShape(Circle())
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
