//
//  AddAttendeeView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 16.08.22.
//

import SwiftUI

struct AttendeeFullView: View {
    var editHandler: (User) -> Void
    @Environment(\.dismiss) var dismiss
    var attendee: User?

    @State private var userName: String
    @State private var lastTimeMeet = Date.now

    @State private var imageToShow: Image? = nil
    @State private var userPhoto: UIImage? = nil
    @State private var showImagePicker = false
    @State private var showMapData = false
    
    init(attendee: User? = nil, editHandler: @escaping (User) -> Void) {
        self.attendee = attendee
        self.editHandler = editHandler

        self._userName = State(initialValue: attendee?.fullName ?? "")
        self._userPhoto = State(initialValue: DataManager.shared.loadPhoto(for: attendee))
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 0.25)
                        .rotation(Angle(degrees: 45))

                    Circle()
                        .opacity(0.25)

                    Text("Tap to add photo")
                        .font(.title3)

                    imageToShow?
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                }
                .onAppear {
                    if let attendee = attendee {
                        imageToShow = Image(uiImage: DataManager.shared.loadPhoto(for: attendee))
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 1.5)
                .onTapGesture {
                    showImagePicker = true
                    if let userPhoto = userPhoto {
                        imageToShow = Image(uiImage: userPhoto)
                    }
                }

                Form {
                    Section {
                        TextField("User name", text: $userName)

                        DatePicker("Last time meet", selection: $lastTimeMeet, displayedComponents: .date)
                    }
                }
                
                Toggle("Show map data", isOn: $showMapData)
                
                Text("Map View Placeholder")
                    .opacity(showMapData ? 1 : 0)
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
                            editHandler(newUser)
                            if let userPhoto = userPhoto {
                                DataManager.shared.savePhoto(photo: userPhoto, for: newUser)
                            }
                            dismiss()
                        } label: {
                            Text("Save")
                        }
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                // Untestable camera
                // UIImagePicker(image: $userPhoto, imageSource: .camera)
                ImagePicker(image: $userPhoto)
            }
            .onChange(of: userPhoto) { _ in
                if let userPhoto = userPhoto {
                    imageToShow = Image(uiImage: userPhoto)
                }
            }
        }
    }
}

struct AddAttendeeView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeFullView(editHandler: { _ in })
    }
}
