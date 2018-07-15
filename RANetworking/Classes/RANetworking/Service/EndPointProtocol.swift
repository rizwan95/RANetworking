//
//  EndPointProtocol.swift
//  NetworkLayer
//
//  Created by Rizwan Ahmed A.
//  Copyright © 2018 Rizwan Ahmed A. All rights reserved.
//

import Foundation

protocol EndPointProtocol {
    var baseURL : URL {get}
    var path : String {get}
    var httpMethod : HTTPMethod {get}
    var task : HTTPTask {get}
    var headers : HTTPHeaders? {get}
}
