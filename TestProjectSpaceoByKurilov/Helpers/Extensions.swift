//
//  Extensions.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 15.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

//MARK: - Extension UIColor
extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

//MARK: - Extension UIView
extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
        //    view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: (format), options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}
