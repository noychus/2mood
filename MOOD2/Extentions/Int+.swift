//
//  Int+.swift
//  MOOD2
//
//  Created by NOY on 17.10.2024.
//

import Foundation

extension Int {
    func formattedPrice() -> String {
        let thousands = self / 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.usesGroupingSeparator = true
        return formatter.string(from: NSNumber(value: thousands)) ?? "\(thousands)"
    }
}
