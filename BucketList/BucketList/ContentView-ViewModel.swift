//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by VITALI KAZLOU on 23.07.22.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var locations: [Location]
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 53.88, longitude: 27.56), span: MKCoordinateSpan(latitudeDelta: 0.077, longitudeDelta: 0.08))
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        
        @Published var authErrorMessage = "Failed to authenticate"
        @Published var showAuthAlert = false

        let savePath = FileManager.documentsDirectory.appendingPathComponent("Saved places")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "some point", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save the data")
            }
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let idx = locations.firstIndex(of: selectedPlace) {
                locations[idx] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please unlock your device"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                    Task { @MainActor in
                        if success {
                            self.isUnlocked = true
                        } else {
                            self.authErrorMessage = "Failed to authenticate"
                            self.showAuthAlert = true
                        }
                    }
                }
            } else {
                authErrorMessage = "No biometrics found"
                showAuthAlert = true
            }
        }
    }
}
