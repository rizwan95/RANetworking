//
//  ParameterEncoding.swift
//  NetworkLayer
//
//  Created by Rizwan Ahmed A.
//  Copyright © 2018 Rizwan Ahmed A. All rights reserved.
//

import Foundation

public typealias Parameters  = [String : Any]

public protocol ParameterEncoder {
    
    static func encode(urlRequest : inout URLRequest, withParameters parameters : Parameters) throws
}
