////
////  AppCoordinator.swift
////  MarvelApp
////
////  Created by Amir Samir on 27/01/21.
////  Copyright © 2018 Amir Samir. All rights reserved.
////
//



import IQKeyboardManagerSwift
import UIKit

extension AppDelegate {
    
    func setRoot(window:UIWindow?){
        self.navigationController.setViewControllers([UIStoryboard.main.homeVC], animated: true)
        
        UIApplication.shared.windows.first?.rootViewController = self.navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
