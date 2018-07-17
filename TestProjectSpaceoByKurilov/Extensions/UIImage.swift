//
//  UIImage.swift
//  TestProjectSpaceoByKurilov
//

import UIKit

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
    
    static func renderImage(_ originalImage: UIImage) -> UIImage {
        let renderImage = originalImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        return renderImage
    }
}
