//
//  Extensions.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 29.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

// MARK: - Extension UIColor
extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

// MARK: - Extension UISearchBar
public extension UISearchBar {
    public func setStyleColor(_ color: UIColor) {
        tintColor = color
        let image: UIImage = UIImage(named: "deffualt")!
        guard let textField = (value(forKey: "searchField") as? UITextField) else { return }
        textField.textColor = color
        if let glassIconView = textField.leftView as? UIImageView, let img = glassIconView.image {
            let newImg = img.blendedByColor(color)
            glassIconView.image = newImg
        }
        self.setBackgroundImage(image.blendedByColor(color), for: UIBarPosition.top, barMetrics: UIBarMetrics.default)
    }
}

// MARK: - Extension UIImage
extension UIImage {
    public func blendedByColor(_ color: UIColor) -> UIImage! {
        let scale = UIScreen.main.scale
        if scale > 1 {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
        } else {
            UIGraphicsBeginImageContext(size)
        }
        color.setFill()
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIRectFill(bounds)
        draw(in: bounds, blendMode: .destinationIn, alpha: 1)
        let blendedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return blendedImage!
    }
}

// MARK: - Extension String
extension String {
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

// MARK: - Extension UIView
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: (format), options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}
