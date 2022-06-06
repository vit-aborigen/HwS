//
//  ContentView.swift
//  World Scramble
//
//  Created by VITALI KAZLOU on 5.06.22.
//

import SwiftUI

struct ContentView: View {
    
    enum currentFocus: Hashable {
        case inputNewWordField
    }
    
    @StateObject var myVM = GameViewModel()
    @FocusState private var focusedControl: currentFocus?
    
    var score: Int {
        var sum: Int = 0
        if myVM.userWords.isEmpty {
            return sum
        }
        
        for word in myVM.userWords {
            sum += word.count
        }
        return sum
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $myVM.newWord) {
                        myVM.addWord()
                        focusedControl = .inputNewWordField
                    }
                    .focused($focusedControl, equals: .inputNewWordField)
                    .autocapitalization(.none)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Text("Your score:")
                        Text("\(score)")
                        Spacer()
                    }
                    .font(.title)
                }
                
                Section {
                    ForEach(myVM.userWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text("\(word)")
                        }
                    }
                }
            }
            .navigationTitle(myVM.rootWord)
            .toolbar {
                Button("Restart", action: myVM.pickANewWord)
            }
        }
        .onAppear(perform: myVM.pickANewWord)
        .alert(myVM.errorTitle, isPresented: $myVM.showError) {
            Button("OK") { }
        } message: {
            Text(myVM.errorMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
