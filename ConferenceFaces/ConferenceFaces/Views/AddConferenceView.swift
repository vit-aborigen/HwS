//
//  AddConferenceView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 15.08.22.
//

import SwiftUI

struct AddConferenceView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showAddAttendees = false

    @State private var conferenceName = ""
    @State private var conferencePlace = ""
    @State private var conferenceDate = Date.now
    @State private var conferenceAttendees = [User]()

    let addHandler: (Conference) -> Void

    var body: some View {
        Form {
            Section {
                TextField("Conference name", text: $conferenceName)
                TextField("Conference place", text: $conferencePlace)
            } header: {
                Text("Conference details")
            }

            DatePicker("Conference Date", selection: $conferenceDate, displayedComponents: .date)
                .pickerStyle(.wheel)

            Section {
                HStack {
                    Button {
                        showAddAttendees = true
                    } label: {
                        Text("Add attendee")
                    }
                }
                .frame(minWidth: .none, maxWidth: .infinity)
                
                ForEach(conferenceAttendees, id: \.self) { user in
                    Text(user.fullName)
                }
            } header: {
                Text("Attendees")
            }
        }
        .navigationTitle("Add new conference")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                let newConference = Conference(name: conferenceName, place: conferencePlace, date: conferenceDate, attendees: conferenceAttendees)
                addHandler(newConference)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
            }
        }
        .sheet(isPresented: $showAddAttendees) {
            AddAttendeeView { user in
                conferenceAttendees.append(user)
            }
        }
    }
}

struct AddConferenceView_Previews: PreviewProvider {
    static var previews: some View {
        AddConferenceView(addHandler: { _ in })
    }
}
