//
//  ApiManager.swift
//  VoodooTest
//
//  Created by Martreux Steven on 22/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation

final class ApiManager: NSObject {
    
    private var appTweak: RequestManager?
    private let dataManager: DataManager = .shared
    
    static let shared = ApiManager()
    
    override init() {
        super.init()
        appTweak = RequestManager(url: ConstantAPI.urlAppTweak)
    }
        
    // MARK: AppTweak
    
    func mock() -> [Application] {
        let app = [Application(), Application(), Application(), Application()]
        return app
    }
    
    func getBestApps(completion: @escaping ([Application]?, Error?) -> ()) {
        let cacheApps = dataManager.getApplications()
        completion(cacheApps, nil)
        let request = Request(requestHTTPType: .get, path: "categories/0/top.json?country=fr&language=fr&device=iphone&type=grossing",
                              parameters: [:], header: nil)
        request.resultCompletion = { [weak self] data, error in
            guard let strongSelf = self else { return }
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                // should send an error
                completion(nil, nil)
                return
            }
            guard let appsDictionnaryArray = data[ConstantJSONKey.content] as? [[String: Any]] else { return }
            var apps: [Application] = []
            for dict in appsDictionnaryArray {
                let app = Application()
                app.setupWith(dictionnary: dict)
                apps.append(app)
            }
            print("Apps Count : \(apps.count)")
            DispatchQueue.main.async {
                strongSelf.dataManager.deleteApps()
                strongSelf.dataManager.save(apps: apps)
                completion(apps, nil)
            }
        }
        appTweak?.send(request: request)
    }
    
}
