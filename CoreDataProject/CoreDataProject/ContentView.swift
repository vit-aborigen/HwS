//
//  ContentView.swift
//  CoreDataProject
//
//  Created by VITALI KAZLOU on 26.06.22.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var ships: FetchedResults<Ship>
    
    var body: some View {
        Text("123")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
