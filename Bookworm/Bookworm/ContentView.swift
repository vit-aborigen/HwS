//
//  ContentView.swift
//  Bookworm
//
//  Created by VITALI KAZLOU on 22.06.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>

    @State private var showAddBook = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(books) { book in
                        NavigationLink {
                            Text(book.title ?? "N/A")
                        } label: {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "N/A")
                                    .font(.headline)
                                Text(book.author ?? "N/A")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .navigationTitle("Bookworm")
                .toolbar {
                    Button {
                        showAddBook.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showAddBook) {
                        AddBookView()
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
