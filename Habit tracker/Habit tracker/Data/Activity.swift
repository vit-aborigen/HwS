//
//  Activity.swift
//  Habit tracker
//
//  Created by VITALI KAZLOU on 19.06.22.
//

import Foundation

enum ActivityType: String, CaseIterable, Codable {    
    case study = "Study"
    case entertainment = "Enterteinment"
    case sport = "Sport"
    case work = "Work"
}

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    let type: ActivityType
    var timeSpent: Int = 0
    let goal: Int?
}
