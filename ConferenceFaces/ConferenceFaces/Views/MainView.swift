//
//  ContentView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 9.08.22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var confVM = ConferenceViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(confVM.conferences, id: \.id) { conference in
                        NavigationLink {
                            ConferenceEditView (conference: conference) { updatedConference in
                                confVM.updateConference(oldConference: conference, newConference: updatedConference)
                            }
                        } label: {
                            ConferenceBriefView(conf: conference)
                        }
                    }
                    .onDelete(perform: confVM.removeConference)
                }

                Spacer()

                HStack {
                    Spacer()

                    NavigationLink {
                        ConferenceEditView { conference in
                            confVM.addConference(newConference: conference)
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.title.bold())
                            .padding()
                            .background(.black.opacity(0.7))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
