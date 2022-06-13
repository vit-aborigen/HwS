//
//  ContentView.swift
//  iExpense
//
//  Created by VITALI KAZLOU on 13.06.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var isAddItemShown = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack (alignment: .leading) {
                            Text("\(item.name)")
                                .font(.headline)
                            
                            Text("\(item.type.rawValue)")
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpenses")
            .toolbar {
                Button {
                    isAddItemShown = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isAddItemShown) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
