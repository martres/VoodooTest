//
//  UIDateExtension.swift
//  VoodooTest
//
//  Created by Martreux Steven on 28/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation

extension Date {
    
    static func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd LLLL"
        return formatter.string(from: date).capitalized
    }
    
}
