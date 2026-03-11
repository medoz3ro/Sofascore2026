//
//  AppColors.swift
//  Sofascore
//
//  Created by Benjamin on 10.03.2026..
//
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}


enum AppColors {
    static let grayText = UIColor(hex: "#121212").withAlphaComponent(0.6)
    static let liveRed = UIColor(hex: "#E93030")
}
