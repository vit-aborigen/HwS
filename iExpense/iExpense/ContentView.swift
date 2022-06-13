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
                ExpensesHistory(title: "Personal expenses", expenses: expenses.personalItems, deleteItems: removePersonalItems)
                
                ExpensesHistory(title: "Business expenses", expenses: expenses.businessItems, deleteItems: removeBusinessItems)
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
    
    func removeItems(at offsets: IndexSet, in array: [ExpenseItem]) {
        var itemsToDelete = IndexSet()
        
        for offset in offsets {
            let item = array[offset]
            
            if let idx = expenses.items.firstIndex(of: item) {
                itemsToDelete.insert(idx)
            }
        }
        
        expenses.items.remove(atOffsets: itemsToDelete)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
