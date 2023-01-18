//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by VITALI KAZLOU on 29.05.22.
//

import SwiftUI

struct ContentView: View {
    @State private var isUserNewToBiorhythms = true
    
    var body: some View {
        ZStack {
            CurrentScreen()

            if isUserNewToBiorhythms {
                DimScreen(placeHintAt: CGSize(width: 20, height: 100), hintSize: CGSize(width: 100, height: 300))
                    .onTapGesture {
                        isUserNewToBiorhythms = false
                    }
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
        ZStack(alignment: .topLeading) {
            Color.black.opacity(0.8)
            
            VStack(spacing: 0) {
                Rectangle()
                    .frame(width: hintSize.width, height: hintSize.height)
                    .blendMode(.destinationOut)
                    .padding(.bottom, 3)
                
                HintArrow()
                    .frame(width: 18, height: 13)
                    .foregroundColor(.white)
                
                BiorhythmOnboardingMessage()
                    .frame(width: 358, height: 115)
            }
            .offset(placeHintAt)
        }
        .compositingGroup()
    }
}

struct BiorhythmOnboardingMessage: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
            
            VStack {
                Text("Here you can scroll the chart and track changes for other days")
                
                Text("GOT IT")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
            }
        }
    }
}

struct HintArrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.50563*width, y: height))
        path.addLine(to: CGPoint(x: 0.99412*width, y: height))
        path.addCurve(to: CGPoint(x: 0.89836*width, y: 0.91785*height), control1: CGPoint(x: 0.95475*width, y: height), control2: CGPoint(x: 0.91832*width, y: 0.96875*height))
        path.addLine(to: CGPoint(x: 0.60139*width, y: 0.1608*height))
        path.addCurve(to: CGPoint(x: 0.40986*width, y: 0.1608*height), control1: CGPoint(x: 0.55843*width, y: 0.05127*height), control2: CGPoint(x: 0.45283*width, y: 0.05127*height))
        path.addLine(to: CGPoint(x: 0.1129*width, y: 0.91785*height))
        path.addCurve(to: CGPoint(x: 0.01714*width, y: height), control1: CGPoint(x: 0.09294*width, y: 0.96875*height), control2: CGPoint(x: 0.0565*width, y: height))
        path.addLine(to: CGPoint(x: 0.50563*width, y: height))
        path.closeSubpath()
        return path
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}
