//
//  ActivitiesListView.swift
//  Habit tracker
//
//  Created by VITALI KAZLOU on 19.06.22.
//

import SwiftUI

struct ActivitiesListView: View {
    @ObservedObject var activityTracker: Tracker
    
    var body: some View {
        List (activityTracker.activities) { activity in
            NavigationLink {
                DetailedActivityView(activity: activity, activities: activityTracker)
            } label: {
                HStack {
                    Text(activity.title)
                    
                    Spacer()
                    
                    Text(activity.goal == 0 ? "No goal" : "\(activity.timeSpent)" + " of \(activity.goal!) done")
                        .font(.caption.weight(.black))
                        .padding(5)
                        .frame(minWidth: 10)
                        .background(colorCompletionRate(activity: activity))
                    
                }
            }
        }
    }
    
    func colorCompletionRate(activity: Activity) -> Color {
        let rate = Double(activity.timeSpent) / Double(activity.goal ?? -1) * 100
        
        switch rate {
        case 0.1..<20: return .red
        case 20.0..<40: return .orange
        case 40.0..<60: return .yellow
        case 60.0..<80: return .purple
        case 80.0...100: return .green
        default: return .black.opacity(0.2)
        }
    }
}
