//
//  MainOrderView.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import SwiftUI

struct MainOrderView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Section {
            Picker("Select your cake", selection: $order.type) {
                ForEach(Cupcakes.allCases, id: \.self) {
                    Text("\($0.rawValue)")
                }
            }
            .pickerStyle(.segmented)
            
            Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 1...20)
        }
        
        Section {
            Toggle("Any special request?", isOn: $order.specialRequestEnabled.animation())
        }
        
        if order.specialRequestEnabled {
            Toggle("Add extra frosting?", isOn: $order.extraFrosting)
            
            Toggle("Add extra sprinkles?", isOn: $order.addSprinkles)
        }
    }
}

struct MainOrderView_Previews: PreviewProvider {
    static var previews: some View {
        MainOrderView(order: Order())
    }
}
