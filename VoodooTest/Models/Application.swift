//
//  Application.swift
//  VoodooTest
//
//  Created by Martreux Steven on 22/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class Application: Object {
    
    @objc dynamic var identifier: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var iconURL: String?
    @objc dynamic var developer: String?
    @objc dynamic var rates: Float = 0
    @objc dynamic var price: String?
    
    var iconImage: UIImage?
    
    class func mock() -> Application {
        let app = Application()
        app.identifier = 1
        app.title = "test"
        app.iconURL = "https://scontent-cdt1-1.xx.fbcdn.net/v/t1.0-1/p480x480/1465151_1151570934875921_4699793290279516844_n.png?_nc_cat=1&_nc_ht=scontent-cdt1-1.xx&oh=c7d39af92b3b4feed2fc8c65e2cd35eb&oe=5C832050"
        app.developer = "Facebook"
        app.rates = 1.0
        app.price = "0.0"
        return app
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    func setupWith(dictionnary: [String: Any]) {
        if let id = dictionnary[ConstantJSONKey.id] as? Int {
            self.identifier = id
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
