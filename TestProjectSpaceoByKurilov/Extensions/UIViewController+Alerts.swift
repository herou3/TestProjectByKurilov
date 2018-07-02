//
//  UIViewController+Alerts.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 02.07.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertError(withMessage message: String,
                   title: String,
                   style: UIAlertActionStyle) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: style, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}
