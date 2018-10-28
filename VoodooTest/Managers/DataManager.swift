//
//  DataManager.swift
//  VoodooTest
//
//  Created by Martreux Steven on 28/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation
import RealmSwift

final class DataManager {
    
    static let shared = DataManager()
    
    func getApplications() -> [Application]? {
        let realm = try! Realm()
        let objects = realm.objects(Application.self)
        return objects.count > 0 ? Array(objects) : nil
    }
    
    func deleteApps() {
        let realm = try! Realm()
        let objects = realm.objects(Application.self)
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    func save(apps: [Application]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(apps)
        }
    }
    
}
