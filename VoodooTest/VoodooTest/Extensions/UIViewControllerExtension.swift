//
//  UIViewControllerExtension.swift
//  VoodooTest
//
//  Created by Martreux Steven on 23/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func getIdentifierInStoryboard() -> String {
        return String(describing: self)
    }
    
}
