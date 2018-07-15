//
//  NetworkRouter.swift
//  NetworkLayer
//
//  Created by Rizwan Ahmed A.
//  Copyright © 2018 Rizwan Ahmed A. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletionBlock = (_ data:Data?, _ response : URLResponse?, _ error : Error?) -> ()

protocol NetworkRouter : class {
    
    associatedtype Endpoint : EndPointProtocol
    
    func request(_ route : Endpoint, completion : @escaping NetworkRouterCompletionBlock)
    
    func cancel()
    
}
