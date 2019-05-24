//
//  UIImageViewExtension.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/24/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func setImage(from url: String, withPlaceholder placeholder: UIImage? = nil) {
        guard let url = URL(string: url) else { return }
        if let image = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = image
            return
        }
        image = placeholder
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            imageCache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
