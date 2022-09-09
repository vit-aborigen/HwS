//
//  Prospect.swift
//  Hot Prospects
//
//  Created by VITALI KAZLOU on 6.09.22.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var email = ""
    var isContacted = false
}
