//
//  AddConferenceView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 15.08.22.
//

import SwiftUI

struct ConferenceFullView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showAddAttendees = false

    @State private var conferenceName: String
    @State private var conferencePlace: String
    @State private var conferenceDate: Date
    @State private var conferenceAttendees: [User]

    let saveHandler: (Conference) -> Void
    var conference: Conference?
    
    init(conference: Conference? = nil, trailingConference: @escaping (Conference) -> Void) {
        self.conference = conference
        self.saveHandler = trailingConference
        
        self._conferenceName = State(initialValue: conference?.name ?? "")
        self._conferencePlace = State(initialValue: conference?.place ?? "")
        self._conferenceDate = State(initialValue: conference?.date ?? Date.now)
        self._conferenceAttendees = State(initialValue: conference?.attendees ?? [])
    }

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
                    AttendeeBriefView(attendee: user)
                }
            } header: {
                Text("Attendees")
            }
        }
        .navigationTitle("Conference details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                let newConference = Conference(name: conferenceName, place: conferencePlace, date: conferenceDate, attendees: conferenceAttendees)
                saveHandler(newConference)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
            }
        }
        .sheet(isPresented: $showAddAttendees) {
            AttendeeFullView { user in
                conferenceAttendees.append(user)
            }
        }
    }
}

struct AddConferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceFullView(trailingConference: { _ in })
    }
}
