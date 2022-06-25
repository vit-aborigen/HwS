//
//  ContentView.swift
//  Bookworm
//
//  Created by VITALI KAZLOU on 22.06.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>

    @State private var showAddBook = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(books) { book in
                        NavigationLink {
                            DetailsView(book: book)
                        } label: {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("\(book.title ?? "N/A") (\(book.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"))")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .primary)
                                Text(book.author ?? "N/A")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: deleteBook)
                }
                .navigationTitle("Bookworm")
                .sheet(isPresented: $showAddBook) {
                    AddBookView()
                }
                .toolbar {
                    ToolbarItem (placement: .navigationBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItem (placement: .navigationBarTrailing) {
                        Button {
                            showAddBook.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
