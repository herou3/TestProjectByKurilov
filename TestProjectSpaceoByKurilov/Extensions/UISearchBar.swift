//
//  UISearchBar.swift
//  TestProjectSpaceoByKurilov
//

import UIKit

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
        self.setBackgroundImage(image.blendedByColor(color),
                                for: UIBarPosition.top,
                                barMetrics: UIBarMetrics.default)
    }
}
