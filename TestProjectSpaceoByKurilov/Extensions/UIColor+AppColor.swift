//
//  UIColor+AppColor.swift
//  TestProjectSpaceoByKurilov
//

import UIKit

// MARK: - Common
extension UIColor {
    static func color(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
// MARK: - AppColors
    class var darkGreen: UIColor {
        return color(0, 100, 0)
    }
    
    class var murkyRating: UIColor {
        return color(60, 179, 113)
    }
    
    class var averageRaiting: UIColor {
        return color(124, 252, 0)
    }
    
    class var dimRaiting: UIColor {
        return color(124, 252, 0)
    }
    
    class var paleRaiting: UIColor {
        return color(173, 255, 47)
    }
    
    class var appPrimary: UIColor {
        return color(34, 139, 34)
    }
    
    class var titleText: UIColor {
        return color(0, 100, 0)
    }
    
    class var descriptionText: UIColor {
        return color(60, 179, 113)
    }
    
    class var dividingLine: UIColor {
        return color(143, 188, 143)
    }
    
    class var searchBar: UIColor {
        return UIColor.color(65, 155, 65)
    }
}
