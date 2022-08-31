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
    var confLocation: CLLocationCoordinate2D?
    var points = Array<Location>()
    
    init(location: CLLocationCoordinate2D?) {
        if let location = location {
            points.append(Location(id: UUID(), latitude: location.latitude, longitude: location.longitude))
        }
    }
    
    var body: some View {
        Map(coordinateRegion: $mapVM.mapRegion, annotationItems: points) { location in
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
        MapView(location: CLLocationCoordinate2D(latitude: 22.3, longitude: 22.2))
    }
}
