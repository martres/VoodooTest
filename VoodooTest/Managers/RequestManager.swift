//
//  RequestManager.swift
//  VoodooTest
//
//  Created by Martreux Steven on 22/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation

final class RequestManager: NSObject {
    
    private(set) var currentRequest: Request? {
        didSet {
            startRequest()
        }
    }
    
    private var url: String
    private let session: URLSession = .shared
    
    init(url: String) {
        self.url = url
    }
    
    func send(request: Request) {
        self.currentRequest = request
    }
    
    private func basicHeaders() -> [String: String] {
        return ["Content-Type": "application/json",
                "accept": "application/json",
                "X-Apptweak-Key": "V9vt_voZ0V-vSIQoHgvGc1Q1M_I"]
    }
    
    private func startRequest() {
        guard let currentRequest = currentRequest else { return }
        guard let url = URL(string: url + currentRequest.path) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = currentRequest.requestHTTPType.rawValue
        request.allHTTPHeaderFields = basicHeaders()
        let task = session.dataTask(with: request, completionHandler: { (data, urlResponse, error) in
            guard error == nil else {
                print("Request failed")
                currentRequest.error = error
                return
            }
            
            guard let data = data else {
                print("Request failed")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("Request success")
                    currentRequest.dataResult = json
                }
            } catch let error {
                currentRequest.error = error
            }
        })
        task.resume()
    }
    
    
}
