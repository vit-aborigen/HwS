//
//  AddActivityView.swift
//  Habit tracker
//
//  Created by VITALI KAZLOU on 19.06.22.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var activities: Tracker
    
    @State private var activityName = ""
    @State private var activityDescription = ""
    @State private var activityType = ActivityType.study
    @State private var activityGoal = 0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Activity name", text: $activityName)
                
                TextField("Activity description", text: $activityDescription)
                    .lineLimit(3)
                
                Picker("Activity type", selection: $activityType) {
                    ForEach(ActivityType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                    .pickerStyle(.segmented)
                
                Picker(activityGoal == 0 ? "No goal" : "Goal: \(activityGoal) times", selection: $activityGoal) {
                    ForEach(0..<101) {
                        Text("\($0)")
                            .tag($0)
                    }
                    .pickerStyle(.wheel)
                }
            }
            .navigationTitle("Add new activity")
            .toolbar {
                Button {
                    let newActivity = Activity(id: UUID(), title: activityName, description: activityDescription, type: activityType, timeSpent: 0, goal: activityGoal)
                    activities.activities.append(newActivity)
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}
