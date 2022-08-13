//
//  ContentView.swift
//  ConferenceFaces
//
//  Created by VITALI KAZLOU on 9.08.22.
//

import SwiftUI

struct MainView: View {
    @StateObject private var confVM = ConferenceViewModel()

    @State private var showAddConferenceDialog = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(confVM.conferences, id: \.id) { conference in
                        NavigationLink {
                            
                        } label: {
                            ConferenceBriefView(conf: conference)
                        }
                    }
                    .onDelete(perform: confVM.removeConference)
                }

                Spacer()

                HStack {
                    Spacer()

                    Button {
                        confVM.addConference(name: "test", place: "test", date: Date.now)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
