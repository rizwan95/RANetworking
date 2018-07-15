//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Rizwan Ahmed A.
//  Copyright © 2018 Rizwan Ahmed A. All rights reserved.
//

import Foundation

struct NetworkManager{
    static let environment : NetworkEnvironment = .production
    private let router = Router<Weather>()
    
    
    func getWeatherData(completion: @escaping (_ response: Any?,_ error: String?)->()){
        router.request(.weatherAPI) { data, response, error in
            
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.nodata.rawValue)
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        completion(jsonData,nil)
                    }catch {
                        completion(nil, NetworkResponse.unknown.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...500: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

enum NetworkResponse  : String {
    case success
    case authenticationError = "Authentication error"
    case badRequest = "Bad request"
    case unknown = "Unknown error"
    case nodata = "No data"
    case outdated = "OutDated"
    case failed = "Failed"
}

enum Result<String>{
    case success
    case failure(String)
}

