//
//  View_model.swift
//  World Scramble
//
//  Created by VITALI KAZLOU on 6.06.22.
//

import Foundation
import SwiftUI
import UIKit

class GameViewModel: ObservableObject {
    
    @Published var userWords = Array<String> ()
    @Published var rootWord = ""
    @Published var newWord = ""
    
    @Published var errorTitle = ""
    @Published var errorMessage = ""
    @Published var showError = false

    func pickANewWord () {
        if let wordsBundle = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: wordsBundle) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "Aardvark"
                userWords = []
                return
            }
        }
        fatalError("Can't load words from the file")
    }
    
    func addWord() {
        let possibleNewWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard possibleNewWord.count > 0 else { return }
        
        if isUnique(word: newWord) && isPossibleToBuild(from: newWord) && isValidWord(word: newWord) && isLongEnough(word: newWord) {
            withAnimation {
                userWords.insert(possibleNewWord, at: 0)
            }
        }
        
        newWord = ""
    }
    
    func isPossibleToBuild(from word: String) -> Bool {
        var tmpRootWord = rootWord
        
        for char in word {
            if tmpRootWord.contains(char) {
                if let position = tmpRootWord.firstIndex(of: char) {
                    tmpRootWord.remove(at: position)
                }
            } else {
                showError(title: "\"\(word)\" isn't valid", message: "You can't build this world from the letters you have")
                return false
            }
        }
        return true
    }
    
    func isValidWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let result = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if result.location == NSNotFound {
            return true
        }
        showError (title: "\"\(word)\" isn't valid word", message: "Please, specify another word")
        return false
    }
    
    func isLongEnough(word: String) -> Bool {
        if word.count > 2 {
            return true
        }
        showError(title: "Can't count \"\(word)\"", message: "Worlds have to be at least 3 letters long")
        return false
    }
        
    func isUnique(word: String) -> Bool {
        if !userWords.contains(word) {
            return true
        }
        showError(title: "\"\(word)\" is used already", message: "Please, specify another word")
        return false
    }
    
    func showError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
}
