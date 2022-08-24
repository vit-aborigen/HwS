//
//  ContentView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 9.08.22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(appState.conferences, id: \.id) { conference in
                        NavigationLink {
                            ConferenceFullView (conference: conference) { updatedConference in
                                appState.updateConference(oldConference: conference, newConference: updatedConference)
                            }
                        } label: {
                            ConferenceBriefView(conf: conference)
                        }
                    }
                    .onDelete(perform: appState.removeConference)
                }

                Spacer()

                HStack {
                    Spacer()

                    NavigationLink {
                        ConferenceFullView { conference in
                            appState.addConference(newConference: conference)
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
