//
//  Constants.swift
//  TestProjectSpaceoByKurilov
//

import Foundation
import UIKit

struct Constant {
    static var appName: String? {
        return Bundle.main.infoDictionary!["CFBundleName"] as? String
    }
    static let navBarFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
    static let marginLeftAndRight: CGFloat = 32.0
    static let baseUrl: String = "https://test.space-o.ru/"
    static let cellHeight: CGFloat = 190.0
}
