//
//  ContentView.swift
//  Project9_drawing_exam
//
//  Created by VITALI KAZLOU on 17.06.22.
//

import SwiftUI

struct Arrow: Shape {
    let arrowOffset = 40.0
    var rotationAngle: Double
    
    var animatableData: Double {
        get {
            rotationAngle
        }
        set {
            rotationAngle = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - arrowOffset, y: rect.midY - arrowOffset))
        path.addLine(to: CGPoint(x: rect.maxX - arrowOffset, y: rect.midY + arrowOffset))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.closeSubpath()
        
        let transform = CGAffineTransform(rotationAngle: rotationAngle)
        return path.applying(transform)
    }
}

struct ContentView: View {
    @State private var rotationAngle = 0.0
    
    var body: some View {
            VStack {
                Arrow(rotationAngle: rotationAngle)
                    .stroke(.red, lineWidth: 10)
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        withAnimation {
                            rotationAngle = Double.random(in: -1.0...1.0)
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
