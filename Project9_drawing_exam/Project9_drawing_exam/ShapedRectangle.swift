//
//  ShapedRectangle.swift
//  Project9_drawing_exam
//
//  Created by VITALI KAZLOU on 18.06.22.
//

import SwiftUI

struct ShapedRectangle: View {
    var amount = 0.0
    var steps = 100
    
    @State private var startX: Double = 0.0
    @State private var endX: Double = 1.0
    @State private var startY: Double = 0.0
    @State private var endY: Double = 1.0

    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<steps) { value in
                    Rectangle()
                        .inset(by: Double(value))
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    color(for: value, brightness: 1),
                                    color(for: value, brightness: 0.5)
                                ]),
                                startPoint: UnitPoint(x: startX, y: startY),
                                endPoint: UnitPoint(x: endX, y: endY)
                            ),
                            lineWidth: 2
                        )
                }
            }
            .drawingGroup()
            
            Text("InitialX")
            Slider(value: $startX, in: 0.0...1.0)
            
            Text("EndX")
            Slider(value: $endX, in: 0.0...1.0)
            
            Text("InitialY")
            Slider(value: $startY, in: 0.0...1.0)
            
            Text("EndY")
            Slider(value: $endY, in: 0.0...1.0)
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ShapedRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ShapedRectangle()
    }
}
