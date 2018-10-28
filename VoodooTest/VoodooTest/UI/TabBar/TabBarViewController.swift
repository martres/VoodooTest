//
//  TabBarViewController.swift
//  VoodooTest
//
//  Created by Martreux Steven on 28/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private var todayController: UIViewController!
    let rooterManager: RooterManager = RooterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todayController = rooterManager.todayController()
        viewControllers = [todayController]
    }
    
}
