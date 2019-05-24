//
//  UIViewExtension.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/24/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setRounded() {
        frame.size.width >= frame.size.height ? setRoundedByWidth() : setRoundedByHeight()
    }

    func setRoundedByHeight() {
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
    }

    func setRoundedByWidth() {
        layer.cornerRadius = frame.size.width / 2
        layer.masksToBounds = true
    }
}
