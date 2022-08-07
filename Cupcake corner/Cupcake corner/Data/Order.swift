//
//  Order.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import Foundation

enum Cupcakes: String, CaseIterable, Codable {
    case vanilla = "Vanilla"
    case strawberry = "Strawberry"
    case chocolate = "Chocolate"
    case rainbow = "Rainbow"
}

enum CodingKeys: CodingKey {
    case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
}

@dynamicMemberLookup
class SharedOrder: ObservableObject {
    @Published var data = Order()
    
    subscript<T>(dynamicMember keyPath: KeyPath<Order, T>) -> T {
        data[keyPath: keyPath]
    }

    subscript<T>(dynamicMember keyPath: WritableKeyPath<Order, T>) -> T {
        get {
            data[keyPath: keyPath]
        }

        set {
            data[keyPath: keyPath] = newValue
        }
    }
    
    /* OLD Decodable conformance
     
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
        
         try container.encode(type, forKey: .type)
         try container.encode(quantity, forKey: .quantity)
         try container.encode(extraFrosting, forKey: .extraFrosting)
         try container.encode(addSprinkles, forKey: .addSprinkles)
         try container.encode(name, forKey: .name)
         try container.encode(streetAddress, forKey: .streetAddress)
         try container.encode(city, forKey: .city)
         try container.encode(zip, forKey: .zip)
     }
    
     required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
        
         type = try container.decode(Cupcakes.self, forKey: .type)
         quantity = try container.decode(Int.self, forKey: .quantity)
         extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
         addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
         name = try container.decode(String.self, forKey: .name)
         streetAddress = try container.decode(String.self, forKey: .streetAddress)
         city = try container.decode(String.self, forKey: .city)
         zip = try container.decode(String.self, forKey: .zip)
     }
    
     init() { }
     
     */
}

struct Order: Codable {
    var type = Cupcakes.vanilla
    var quantity = 1
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasIncorrectAddress: Bool {
        name.isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.isEmpty || zip.isEmpty
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
