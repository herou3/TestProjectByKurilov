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
    static let marginLeftAndRight: CGFloat = 32.0
    static let baseUrl: String = "https://test.space-o.ru/"
    static let cellHeight: CGFloat = 310
    static let maxImagesCount: Int = 10
}
