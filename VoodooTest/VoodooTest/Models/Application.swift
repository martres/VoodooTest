//
//  Application.swift
//  VoodooTest
//
//  Created by Martreux Steven on 22/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation
import UIKit

final class Application: NSObject {
    
    private(set) var id: Int?
    private(set) var title: String?
    private(set) var iconURL: String?
    private(set) var developer: String?
    private(set) var rates: Float?
    private(set) var price: String?
    
    var iconImage: UIImage?
    
    override init() {
        self.id = 1
        self.title = "test"
        self.iconURL = "https://scontent-cdt1-1.xx.fbcdn.net/v/t1.0-1/p480x480/1465151_1151570934875921_4699793290279516844_n.png?_nc_cat=1&_nc_ht=scontent-cdt1-1.xx&oh=c7d39af92b3b4feed2fc8c65e2cd35eb&oe=5C832050"
        self.developer = "Facebook"
        self.rates = 1.0
        self.price = "0.0"
    }
    
    init(dictionnary: [String: Any]) {
        if let id = dictionnary[ConstantJSONKey.id] as? Int {
            self.id = id
        }
        if let title = dictionnary[ConstantJSONKey.title] as? String {
            self.title = title
        }
        if let iconURL = dictionnary[ConstantJSONKey.icon] as? String {
            self.iconURL = iconURL
        }
        if let developer = dictionnary[ConstantJSONKey.developer] as? String {
            self.developer = developer
        }
        if let rates = dictionnary[ConstantJSONKey.rating] as? Float {
            self.rates = rates
        }
        if let price = dictionnary[ConstantJSONKey.price] as? String {
            self.price = price
        }
    }
    
    
    
}
