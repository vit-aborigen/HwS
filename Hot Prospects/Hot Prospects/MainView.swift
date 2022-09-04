//
//  ContentView.swift
//  Hot Prospects
//
//  Created by VITALI KAZLOU on 1.09.22.
//

import SwiftUI

@MainActor
class DelayedUpdater: ObservableObject {
    var value: Int = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct MainView: View {
    @StateObject var testObject = DelayedUpdater()
    
    var body: some View {
        Text("\(testObject.value)")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
