//
//  AddView.swift
//  iExpense
//
//  Created by VITALI KAZLOU on 13.06.22.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = ExpenseTypes.personal
    @State private var amount = 0.0
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name: ", text: $name)
                
                Picker("Type: ", selection: $type) {
                    ForEach(ExpenseTypes.allCases, id: \.self) {
                        Text("\($0.rawValue)")
                    }
                    
                }
                .pickerStyle(.segmented)
                
                TextField("Amount", value: $amount, format: .localCurrency)
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("Add new item")
            .toolbar {
                Button {
                    let expense = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(expense)
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
