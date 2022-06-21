//
//  NameView.swift
//  ViewsAndModifiers
//
//  Created by VITALI KAZLOU on 21.06.22.
//

import SwiftUI

struct NameView: View {
    @ObservedObject var testClass: Test
    @ObservedObject var myOrder: Order?
    
    var body: some View {
        Form {
            TextField("Hello", text: $testClass.name)
        }
        .onSubmit {
            var myOrder = Order(name: testClass.name)
            // save to wherenever
        }
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView(testClass: Test(name: "123"))
    }
}
