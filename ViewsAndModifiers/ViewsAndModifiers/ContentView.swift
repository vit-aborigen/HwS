//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by VITALI KAZLOU on 29.05.22.
//

import SwiftUI

struct ContentView: View {
    var isUserNewToBiorhythms = true
    
    var body: some View {
        ZStack {
            CurrentScreen()

            if isUserNewToBiorhythms {
                DimScreen(placeHintAt: CGSize(width: 50, height: 100), hintSize: CGSize(width: 100, height: 300))
            }
        }
    }
}

struct CurrentScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.red
                    Text("Top")
                }

                ZStack {
                    Color.green
                    Text("Middle")
                }

                ZStack {
                    Color.blue
                    Text("Bottom")
                }
            }
        }
    }
}

struct DimScreen: View {
    let placeHintAt: CGSize
    let hintSize: CGSize

    init(placeHintAt: CGSize, hintSize: CGSize) {
        self.placeHintAt = placeHintAt
        self.hintSize = hintSize
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.8)

            Rectangle()
                .frame(width: hintSize.width, height: hintSize.height)
                .offset(placeHintAt)
                .blendMode(.destinationOut)
        }
        .compositingGroup()
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}
