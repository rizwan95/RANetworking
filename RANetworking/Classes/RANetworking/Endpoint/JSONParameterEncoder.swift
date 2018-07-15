//
//  JSONParameterEncoder.swift
//  NetworkLayer
//
//  Created by Rizwan Ahmed A.
//  Copyright © 2018 Rizwan Ahmed A. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder : ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, withParameters parameters: Parameters) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            
            if urlRequest.value(forHTTPHeaderField: "\(HeaderKeyTypes.contentType)") == nil {
                urlRequest.setValue("\(HeaderValueTypes.applicationJSON)", forHTTPHeaderField: "\(HeaderKeyTypes.contentType)")
            }
            
        }catch {
            throw NetworkErrors.encodingFailed
        }
    }
    
    
}
