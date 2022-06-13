//
//  UserNumbersStyle.swift
//  iExpense
//
//  Created by VITALI KAZLOU on 13.06.22.
//

import Foundation
import SwiftUI

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}

extension View {
    func changeFontColor(amount: Double) -> some View {
        switch amount {
        case 0..<15: return foregroundColor(.black)
        case 15..<30: return foregroundColor(.blue)
        case 30..<100: return foregroundColor(.green)
        case 100..<10000: return foregroundColor(.red)
        default: return foregroundColor(.black)
        }
    }
}
