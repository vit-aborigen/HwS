//
//  MainOrderView.swift
//  Cupcake corner
//
//  Created by VITALI KAZLOU on 20.06.22.
//

import SwiftUI

struct MainOrderView: View {
    @ObservedObject var order: SharedOrder
    
    var body: some View {
        Section {
            Picker("Select your cake", selection: $order.data.type) {
                ForEach(Cupcakes.allCases, id: \.self) {
                    Text("\($0.rawValue)")
                }
            }
            .pickerStyle(.segmented)
            
            Stepper("Number of cakes: \(order.data.quantity)", value: $order.data.quantity, in: 1...20)
        }
        
        Section {
            Toggle("Any special request?", isOn: $order.data.specialRequestEnabled.animation())
        }
        
        if order.data.specialRequestEnabled {
            Toggle("Add extra frosting?", isOn: $order.data.extraFrosting)
            
            Toggle("Add extra sprinkles?", isOn: $order.data.addSprinkles)
        }
    }
}

struct MainOrderView_Previews: PreviewProvider {
    static var previews: some View {
        MainOrderView(order: SharedOrder())
    }
}
