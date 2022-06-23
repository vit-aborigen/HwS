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
        VStack {
            Button {
                showAddBook.toggle()
            } label: {
                Text("Add book")
            }
            .sheet(isPresented: $showAddBook) {
                AddBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
