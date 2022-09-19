//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by VITALI KAZLOU on 19.09.22.
//

import SwiftUI

struct EditCardsView: View {
    var cards: [Card]
    var onSave: ([Card]) -> Void
    
    @State private var newCardsStorage: [Card] = []
    
    @Environment(\.dismiss) var dismiss
    @State private var question = ""
    @State private var answer = ""
    
    init(cards: [Card], onSave: @escaping ([Card]) -> Void) {
        self.cards = cards
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("New question", text: $question)
                    
                    TextField("Answer", text: $answer)
                    
                    Button {
                        let card = Card(question: question, answer: answer)
                        newCardsStorage.append(card)
                    } label: {
                        Text("Save card")
                    }
                }
                
                Section {
                    ForEach(newCardsStorage, id: \.self) { card in
                        VStack(alignment: .leading) {
                            Text(card.question)
                                .font(.headline)
                                
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Edit cards")
            .toolbar {
                Button {
                    onSave(newCardsStorage)
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
        EditCardsView(cards: [Card.test], onSave: { _ in })
    }
}
