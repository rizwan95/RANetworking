//
//  Router.swift
//  NetworkLayer
//
//  Created by Rizwan Ahmed A.
//  Copyright © 2018 Rizwan Ahmed A. All rights reserved.
//

import Foundation

typealias RequestSuccessCompletion = (_ urlRequest:URLRequest?) -> ()

typealias RequestFailureCompletion = (_ error:Error?) -> ()

typealias ConfigureParametersSuccessBlock  = (_ urlRequest:URLRequest?) -> ()
typealias ConfigureParametersErrorBlock    = (_ error:Error?) -> ()


class Router<Endpoint : EndPointProtocol>{
    private var task : URLSessionTask?
    
    fileprivate func buildRequest(from route : Endpoint, success : @escaping RequestSuccessCompletion, failure : @escaping RequestFailureCompletion)throws{
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120.0)
        request.httpMethod = route.httpMethod.rawValue
        
        switch route.task {
            case .request:
            request.setValue("\(HeaderValueTypes.applicationJSON)", forHTTPHeaderField: "\(HeaderKeyTypes.contentType)")
        
            case .requestParameters(body: let bodyParameters, urlParameters: let parameters):
            self.configureParameters(body: bodyParameters, urlParameters: parameters, request: &request, success: { (request) in
                success(request)

            }) { (error) in
                failure(error)
            }
            
            case.requestParametersWithHeaders(body: let bodyParameters, urlParameters: let  parameters, headers: let requestHeaders):
            
            self.setAdditionalHeaders(requestHeaders, request: &request)
            self.configureParameters(body: bodyParameters, urlParameters: parameters, request: &request, success: { (request) in
                success(request)
                
            }) { (error) in
                failure(error)
            }
        }
    }
    
    fileprivate func configureParameters(body: Parameters?, urlParameters : Parameters?, request : inout URLRequest, success : @escaping ConfigureParametersSuccessBlock, failure : @escaping ConfigureParametersErrorBlock) {
        
        do {
            if let bodyParameters = body {
                try JSONParameterEncoder.encode(urlRequest: &request, withParameters: bodyParameters)
            }
            if let urlParameters = urlParameters{
                try URLParameterEncoder.encode(urlRequest: &request, withParameters: urlParameters)
            }
            success(request)
        }catch {
            failure(error)
        }
        
    }
    
    fileprivate func setAdditionalHeaders(_ additionalHeader : HTTPHeaders?,request : inout URLRequest){
        
        guard let headers = additionalHeader else{
            return
        }
        for (key,value) in headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

}

extension Router : NetworkRouter{
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletionBlock) {
        let session = URLSession.shared
        
        do{
            try self.buildRequest(from: route, success: { (urlRequest) in
                guard let request = urlRequest else{
                    return
                }
                self.task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    completion(data,response,error)
                })
                self.task?.resume()

            }, failure: { (error) in
                completion(nil,nil,error)
        })
            
        }catch{
            completion(nil,nil,error)
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
