//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 19.09.22.
//

import SwiftUI

struct EditCardsView: View {
    @ObservedObject var cardsVM = EditCardsVM()
    
    @Environment(\.dismiss) var dismiss
    @State private var question = ""
    @State private var answer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("New question", text: $question)
                    TextField("Answer", text: $answer)
                    Button("Save card", action: cardsVM.saveData)
                }
            }
            .navigationTitle("Edit cards")
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
            }
            .listStyle(.grouped)
        }
    }
}

struct EditCardsView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardsView()
    }
}
