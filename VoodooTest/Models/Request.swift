//
//  Request.swift
//  VoodooTest
//
//  Created by Martreux Steven on 22/10/2018.
//  Copyright © 2018 Martreux Steven. All rights reserved.
//

import Foundation

final class Request: NSObject {
    
    private(set) var requestHTTPType: HTTPType
    private(set) var parameters: [String: Any]
    private(set) var header: [String: String]?
    private(set) var path: String
    
    var dataResult: [String: Any]? {
        didSet {
            resultCompletion?(dataResult, nil)
        }
    }
    
    var error: Error? {
        didSet {
            resultCompletion?(nil, error)
        }
    }
    
    var resultCompletion: ((_ result: [String: Any]?, _ error: Error?) -> ())?
    
    init(requestHTTPType: HTTPType,
         path: String,
         parameters: [String: Any] = [:],
         header: [String: String]? = nil) {
        self.requestHTTPType = requestHTTPType
        self.path = path
        self.parameters = parameters
        self.header = header
        super.init()
    }
    
    func info() {
        print("Path: \(path)\nparameters: \(parameters)")
    }
    
}
