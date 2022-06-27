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
    @State private var lastNameFilter = "A"
    @State private var predicateExpression = "BEGINSWITH"
    @State private var sortOrderReverse = false
    
    @State private var sortDescriptors = [SortDescriptor<Singer>]()
    
    var body: some View {
        VStack {
            FilteredList(expression: predicateExpression, filterKey: "lastName", filterValue: lastNameFilter, sortDescriptors: sortDescriptors) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                    let taylor = Singer(context: moc)
                    taylor.firstName = "Taylor"
                    taylor.lastName = "Swift"

                    let ed = Singer(context: moc)
                    ed.firstName = "Ed"
                    ed.lastName = "Sheeran"

                    let adele = Singer(context: moc)
                    adele.firstName = "Adele"
                    adele.lastName = "Adkins"

                    try? moc.save()
                }
            
            Button("Show A") {
                lastNameFilter = "A"
            }
            
            Button("Show S") {
                lastNameFilter = "S"
            }
            
            Picker("Expression", selection: $predicateExpression) {
                ForEach(FilterType.allCases, id: \.self.rawValue) {
                    Text($0.rawValue)
                }
                .pickerStyle(.segmented)
            }
            
            Button("Change order") {
                sortOrderReverse.toggle()
                sortDescriptors = [SortDescriptor(\.lastName, order: sortOrderReverse ? .forward : .reverse)]
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
