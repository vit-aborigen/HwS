//
//  MapViewModel.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 30.08.22.
//

import Foundation
import MapKit

extension MapView {
    @MainActor class MapViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 53.88, longitude: 27.56), span: MKCoordinateSpan(latitudeDelta: 0.077, longitudeDelta: 0.08))
        @Published var location: Location? = nil
    }
}
