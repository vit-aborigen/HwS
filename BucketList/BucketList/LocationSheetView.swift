//
//  LocationSheetView.swift
//  BucketList
//
//  Created by VITALI KAZLOU on 17.07.22.
//

import Foundation
import SwiftUI

struct LocationSheetView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Details")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button { dismiss() } label: {
                        Text("Dismiss")
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        var newLocation = location
                        newLocation.id = UUID()
                        newLocation.name = name
                        newLocation.description = description
                        
                        onSave(newLocation)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        self._name = State(initialValue: location.name)
        self._description = State(initialValue: location.description)
    }
}

struct LocationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSheetView(location: Location.example) { _ in }
    }
}
