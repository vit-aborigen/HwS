//
//  ContentView.swift
//  World Scramble
//
//  Created by VITALI KAZLOU on 5.06.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userWords = Array<String> ()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord, onCommit: addWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(userWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text("\(word)")
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
        }
        .onAppear(perform: pickANewWord)
    }
    
    func addWord() {
        let possibleNewWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard possibleNewWord.count > 0 else { return }
        
        if !userWords.contains(newWord) {
            withAnimation {
                userWords.insert(possibleNewWord, at: 0)
            }
        }
        
        newWord = ""
    }
    
    func pickANewWord () {
        if let wordsBundle = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: wordsBundle) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "Aardvark"
                return
            }
        }
        fatalError("Can't load words from the file")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
