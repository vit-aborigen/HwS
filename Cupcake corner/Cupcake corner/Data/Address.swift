//
//  Adress.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import Foundation

class Address: ObservableObject {
    @Published var userName: String
    @Published var zipCode: Int = 0
    @Published var city: String
    @Published var address: String
    
    var isAddressValid: Bool {
        if userName.isEmpty || city.isEmpty || zipCode == 0 || address.isEmpty {
            return false
        }
        
        return true
    }
    
    init(user: String, zip: Int, city: String, address: String) {
        self.userName = user
        self.zipCode = zip
        self.city = city
        self.address = address
    }
}
