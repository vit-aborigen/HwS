//
//  AddBookView.swift
//  Bookworm
//
//  Created by VITALI KAZLOU on 23.06.22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var title = ""
    @State private var review = ""
    @State private var rating = 3
    @State private var genre = BookGenre.horror
    @State private var author = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(BookGenre.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    
                    Picker("Rating", selection: $rating) {
                        ForEach(1..<6, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre.rawValue
                        newBook.review = review
                        
                        try? moc.save()
                    } label: {
                         Text("Save")
                    }
                }
            }
            .navigationTitle("Add book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
