//
//  HTTPTask.swift
//  NetworkLayer
//
//  Created by Rizwan Ahmed A.
//  Copyright © 2018 Rizwan Ahmed A. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(body : Parameters?, urlParameters : Parameters?)
    
    case requestParametersWithHeaders(body : Parameters?, urlParameters : Parameters?, headers : HTTPHeaders?)
    
}
