//
//  DetailsView.swift
//  Bookworm
//
//  Created by VITALI KAZLOU on 24.06.22.
//

import SwiftUI

struct DetailsView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showDeletionAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Universal")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "N/A")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "N/A")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No rewiew")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
                .scaleEffect()
        }
        .navigationTitle(book.title ?? "N/A")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: $showDeletionAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showDeletionAlert = true
            } label: {
                Image(systemName: "trash")
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(book: Book())
    }
}
