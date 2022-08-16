//
//  AddAttendeeView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 16.08.22.
//

import SwiftUI

struct AddAttendeeView: View {
    var onAdd: (User) -> Void
    @Environment(\.dismiss) var dismiss

    @State private var userName = ""
    @State private var lastTimeMeet = Date.now
    @State private var userPhoto: UIImage? = nil

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("User name", text: $userName)

                    DatePicker("Last time meet", selection: $lastTimeMeet, displayedComponents: .date)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newUser = User(fullName: userName, lastTimeMeet: lastTimeMeet)
                        onAdd(newUser)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

struct AddAttendeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddAttendeeView(onAdd: { _ in })
    }
}
