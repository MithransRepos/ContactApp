//
//  GradientView.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var gradientColor1: UIColor = UIColor.white {
        didSet {
            setGradient()
        }
    }

    @IBInspectable var gradientColor2: UIColor = UIColor.white {
        didSet {
            setGradient()
        }
    }

    @IBInspectable var gradientStartPoint: CGPoint = .zero {
        didSet {
            setGradient()
        }
    }

    @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            setGradient()
        }
    }

    private func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [self.gradientColor1.cgColor, self.gradientColor2.cgColor]
        gradientLayer.startPoint = gradientStartPoint
        gradientLayer.endPoint = gradientEndPoint
        gradientLayer.frame = bounds
        if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
            topLayer.removeFromSuperlayer()
        }
        layer.addSublayer(gradientLayer)
    }
}
