//
//  ContentView.swift
//  Habit tracker
//
//  Created by VITALI KAZLOU on 19.06.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activityTracker = Tracker()
    @State var showAddDialog = false
    
    var body: some View {
        NavigationView {
            ActivitiesListView(activityTracker: activityTracker)
            .navigationTitle("Activities")
            .toolbar {
                Button {
                    showAddDialog.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddDialog) {
                AddActivityView(activities: activityTracker)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
