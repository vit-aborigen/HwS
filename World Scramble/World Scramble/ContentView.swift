//
//  ContentView.swift
//  World Scramble
//
//  Created by VITALI KAZLOU on 5.06.22.
//

import SwiftUI

struct ContentView: View {
    enum currentFocus {
        case inputNewWordField
    }
    
    @StateObject var myVM = GameViewModel()
    @FocusState private var focusedControl: currentFocus?
    
    var score: Int {
        var sum = 0
        
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
                    ForEach(myVM.userWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text("\(word)")
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("\(word), \(word.count) letter")
                    }
                }
            }
            .navigationTitle(myVM.rootWord)
            .toolbar {
                Button("Restart", action: myVM.pickANewWord)
            }
            .safeAreaInset(edge: .bottom) {
                Text("Score: \(score)")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .font(.title)
            }
        }
        .onAppear(perform: myVM.pickANewWord)
        .alert(myVM.errorTitle, isPresented: $myVM.showError) {
            Button("OK") {}
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
