//
//  ContentView.swift
//  theveryfirstapp
//
//  Created by VITALI KAZLOU on 24.05.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipsPercent = 20
    @FocusState private var amountIsFocused: Bool
    
    let defaultCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
   
    let possibleTips = [20, 25, 15, 10, 0]
    
    private var total: Double {
        checkAmount * (Double(tipsPercent)/100 + 1)
    }
    
    private var totalForEachOne: Double {
        (checkAmount / Double(numberOfPeople) * (Double(tipsPercent)/100 + 1))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: defaultCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach (2..<100, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Bill amount and how many people")
                }
                
                Section {
                    Picker("Tips, %", selection: $tipsPercent) {
                        ForEach (possibleTips.sorted(), id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                     Text("How much tip do you want to leave")
                }
                
                Section {
                    Text(total, format: defaultCurrency)
                } header: {
                    Text("Total with tips")
                }
                
                Section {
                    Text(totalForEachOne, format: defaultCurrency)
                } header: {
                    Text("Amount per person")
                }
            }
            
            .navigationTitle("Split the bill")
            .toolbar {
                ToolbarItemGroup (placement: .keyboard) {
                    Spacer()
                    Button("Hide") {
                    amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

