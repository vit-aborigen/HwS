//
//  AddAttendeeView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 16.08.22.
//

import SwiftUI

struct AttendeeFullView: View {
    var onAdd: (User) -> Void
    @Environment(\.dismiss) var dismiss

    @State private var userName = ""
    @State private var lastTimeMeet = Date.now
    
    @State private var imageToShow: Image? = nil
    @State private var userPhoto: UIImage? = nil
    @State private var showImagePicker = false

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
            .sheet(isPresented: $showImagePicker) {
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
        AttendeeFullView(onAdd: { _ in })
    }
}
