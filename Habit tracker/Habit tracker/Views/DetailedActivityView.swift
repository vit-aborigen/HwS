//
//  DetailedActivityView.swift
//  Habit tracker
//
//  Created by VITALI KAZLOU on 19.06.22.
//

import SwiftUI

struct DetailedActivityView: View {
    @Environment(\.dismiss) var dismiss
    var activity: Activity
    var activities: Tracker
    
    var body: some View {
        VStack {
            List {
                Text("Activity: \(activity.title)")
                Text("Decription: \(activity.description)")
                Text("Type: \(activity.type.rawValue)")
                Text(activity.goal == 0 ? "Goal isn't set" : "Current progress: \(activity.timeSpent) of \(activity.goal!)")
            }
            .font(.headline)
            .alignmentGuide(.leading) { d in
                d[.leading]
            }
            
            Button {
                let updatedActivity = Activity(id: activity.id, title: activity.title, description: activity.description, type: activity.type, timeSpent: activity.timeSpent + 1, goal: activity.goal)
                if let idx = activities.activities.firstIndex(of: activity) {
                    activities.activities[idx] = updatedActivity
                }
                dismiss()
            } label: {
                Text("Mark as done")
            }
        }
        .navigationTitle(activity.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailedActivityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedActivityView(activity: Activity(id: UUID(), title: "Test", description: "Test description", type: .study, timeSpent: 5, goal: 15), activities: Tracker())
    }
}
