//
//  UIColorExtension.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/24/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    static var headerGrey: UIColor {
        return UIColor(rgb: 0xE8E8E8)
    }

    static var appBlack: UIColor {
        return UIColor(rgb: 0x4A4A4A)
    }

    static var appgreen: UIColor {
        return UIColor(rgb: 0x50E3C2)
    }
}
