//
//  Order.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import Foundation

enum Cupcakes: String, CaseIterable {
    case vanilla = "Vanilla"
    case strawberry = "Strawberry"
    case chocolate = "Chocolate"
    case rainbow = "Rainbow"
}

class Order: ObservableObject {
    @Published var type = Cupcakes.vanilla
    @Published var quantity = 1
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasIncorrectAddress: Bool {
        (name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty)
    }
    
    var cost: Double {
        let baseCost = 2.0
        var cost = Double(quantity) * baseCost
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / baseCost
        }
        
        return cost
    }
}
