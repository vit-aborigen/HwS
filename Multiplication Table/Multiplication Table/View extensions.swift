//
//  View extensions.swift
//  Multiplication Table
//
//  Created by VITALI KAZLOU on 10.06.22.
//

import SwiftUI

extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric , height: 150)
    }
}

struct ImprovedPicker: ViewModifier {
    func body(content: Content) -> some View {
        content
            .labelsHidden()
            .pickerStyle(.wheel)
            .frame(minWidth: 40, idealWidth: 40, maxWidth: 70, alignment: .bottomTrailing)
            .clipped()
    }
}

extension View {
    func improveForMath() -> some View {
        modifier(ImprovedPicker())
    }
}
