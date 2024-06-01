//
//  AppDelegate.swift
//  Assignment
//
//  Created by M.Shariq Hasnain on 31/05/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let listing = ListingsRouter.createModule()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [listing]

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

   

}

