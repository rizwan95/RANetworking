//
//  URLParameterEncoding.swift
//  NetworkLayer
//
//  Created by Rizwan Ahmed A.
//  Copyright © 2018 Rizwan Ahmed A. All rights reserved.
//

import Foundation

public struct URLParameterEncoder : ParameterEncoder{
    public static func encode(urlRequest: inout URLRequest, withParameters parameters: Parameters) throws {
        
        do{
            guard let url = urlRequest.url else{
                throw NetworkErrors.missingURL
            }
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty{
                
                urlComponents.queryItems = [URLQueryItem]()
                
                for (key,value) in parameters {
                    let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
                urlRequest.url = urlComponents.url

            }
            
            if (urlRequest.value(forHTTPHeaderField: "\(HeaderKeyTypes.contentType)") == nil){
                urlRequest.setValue("\(HeaderValueTypes.applicationForm)\(HeaderValueTypes.utf8Charset)", forHTTPHeaderField: "\(HeaderKeyTypes.contentType)")
            }
        }catch{
            throw NetworkErrors.encodingFailed
        }
    }
    
    
}
