//
//  AppDelegate.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRoot(true, MoviesVC())
        return true
    }
    
    private func setRoot(_ withNavigation: Bool, _ vc: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return }
        
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = withNavigation ? navigationController : vc
        window.makeKeyAndVisible()
    }


}

