//
//  TabBarController.swift
//  Response
//
//  Created by Elmer Astudillo on 2/1/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.tabBar.barTintColor = UIColor.responseBlack
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let homeVC = HomeViewController()
        let homeTab = UITabBarItem(title: "Home", image: UIImage(named: "Home"), selectedImage: UIImage(named:"HomeSelected"))
        homeVC.tabBarItem = homeTab
        
        let updatedVC = UpdatesViewController()
        let updatedTab = UITabBarItem(title: "Updates", image: UIImage(named:"Card"), selectedImage: UIImage(named:"CardSelected"))
        updatedVC.tabBarItem = updatedTab
        
        let userProfileVC = ProfileViewController()
        let profileTab = UITabBarItem(title: "Profile", image: UIImage(named: "ProfileTab"), selectedImage: UIImage(named: "ProfileTabSelected"))
        userProfileVC.tabBarItem = profileTab
        let controllers = [homeVC, updatedVC, userProfileVC]
        self.viewControllers = controllers.map{
            UINavigationController(rootViewController: $0)
        }
    }
}
