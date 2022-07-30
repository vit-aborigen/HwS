//
//  LocationSheetView.swift
//  BucketList
//
//  Created by VITALI KAZLOU on 17.07.22.
//

import Foundation
import SwiftUI

struct LocationSheetView: View {
    @StateObject var editViewVM: LocationViewModel
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        self._editViewVM = StateObject(wrappedValue: LocationViewModel(location: location))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $editViewVM.name)
                    
                    TextField("Description", text: $editViewVM.description)
                }
                
                Section("Nearby...") {
                    switch editViewVM.loadingState {
                    case .loading:
                        Text("Loading")
                    case .loaded:
                        ForEach(editViewVM.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                + Text(": ")
                                + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Failed to load. Please, try again later")
                    }
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
                        onSave(editViewVM.makeNewLocation())
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
            .task {
                await editViewVM.fetchNearbyPlaces()
            }
        }
    }
}

struct LocationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSheetView(location: Location.example) { _ in }
    }
}
