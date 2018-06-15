//
//  AppDelegate.swift
//  TestProjectSpaceoByKurilov
//
//  Created by Pavel Kurilov on 28.05.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        let layout = UICollectionViewFlowLayout()
        self.window?.rootViewController = UINavigationController(rootViewController: RecipesListController(collectionViewLayout: layout))
        // get rid of black bar underneath navbar
        UINavigationBar.appearance().barTintColor = UIColor.rgb(34, 139, 34)
        UINavigationBar.appearance().shadowImage = UIImage()
        application.statusBarStyle = .lightContent
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
 }
