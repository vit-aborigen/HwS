//
//  ExpensesHistory.swift
//  iExpense
//
//  Created by VITALI KAZLOU on 14.06.22.
//

import SwiftUI

struct ExpensesHistory: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack (alignment: .leading) {
                        Text("\(item.name)")
                            .font(.headline)
                        
                        Text("\(item.type.rawValue)")
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .localCurrency)
                        .changeFontColor(amount: item.amount)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}

struct ExpensesHistory_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesHistory(title: "Test", expenses: []) {
            _ in
        }
    }
}
