//
//  SampleEndpoint.swift
//  NetworkLayer
//
//  Created by Rizwan Ahmed A.
//  Copyright © 2018 Rizwan Ahmed A. All rights reserved.
//

import Foundation

public enum NetworkEnvironment {
    case production
    case development
    case local
}

public enum Weather {
    case weatherAPI
    
}

extension Weather : EndPointProtocol {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production:return "https://samples.openweathermap.org/"
            
        default:
            return ""
        }
    }
    
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else{
            fatalError("Base url not configured")
        }
        return url
        
    }
    
    var path: String {
        switch self {
        case .weatherAPI:
            return "data/2.5/weather"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .weatherAPI:
            return .requestParameters(body: nil, urlParameters: ["q":"london","appid":"b6907d289e10d714a6e88b30761fae22"])

        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
