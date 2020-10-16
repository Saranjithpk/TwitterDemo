//
//  NetworkRequest.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 15/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

struct Network {
    
    // Declarations
    fileprivate let messages = Messages()
    fileprivate let keys = GetPostKeys()
    
    // Prepare Request
    fileprivate func buildRequest(to path: APIEndpoint, method: HTTPMethod, encoding: HTTPEncoding, headers: HTTPHeaders, queryParams: Parameters, body: Data) -> URLRequest? {
    
        // Validation
        guard let url = APIEndpoint.baseUrl.url else {
            if logActivity { print(messages.invalidBaseUrl) }
            return nil
        }
        
        // Prepare Full Path
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            if logActivity { print(messages.baseUrlNotResolved) }
            return nil
        }
        urlComponents.path.append(path.string)
        
        // Validate Encoding
        switch encoding {
            
        case .queryUrl:
            urlComponents.queryItems = generateQueryParams(queryParams)
            
        case .json:
            // body already addeded
            break
        }
        
        // Prepare final URL
        guard let completeURL = urlComponents.url else {
            if logActivity { print(messages.baseUrlPreparationfailed) }
            return nil
        }
        
        // Prepare Request
        var request = URLRequest(url: completeURL)
        request.httpMethod = method.name
        request.cachePolicy = getcachePolicy(for: path)
        request.allHTTPHeaderFields = generateHeaders(headers)
        request.httpBody = body
        return request
    }
}

extension Network {
    
    // Support Authentication
    fileprivate func generateHeaders(_ header: HTTPHeaders) -> HTTPHeaders {
        
        var updatedHeaders = header
        updatedHeaders[keys.authorization] = "Bearer AAAAAAAAAAAAAAAAAAAAALYuxQAAAAAAWHfGjSjBqsqK929EGEVvfRVbfaE%3D3Ssf9eWTaCCN9xvb6ktCkcp9txVr23kP1x55CP39ywm3KKP0Ya"
        return updatedHeaders
    }
    
    // Caching
    fileprivate func getcachePolicy(for endPoint: APIEndpoint) -> URLRequest.CachePolicy {
        
        switch endPoint {
            
        case .fetchTweets:
            return .reloadIgnoringCacheData
        default:
            return .useProtocolCachePolicy
        }
    }
}

extension Network {
    
    fileprivate func generateQueryParams(_ params: Parameters) -> [URLQueryItem] {
        
        // Preapre Query URL
        var queryItems: [URLQueryItem] = []
        if params.count > 0 {
            
            params.forEach { (key, value) in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        return queryItems
    }
}

extension Network {
    
    func request(to path: APIEndpoint, method: HTTPMethod, encoding: HTTPEncoding, headers: HTTPHeaders, queryParams: Parameters, body: Data, completion: @escaping (_ networkStatus: Bool, _ responseStatus: Bool, _ data: Data?) -> ()) {
        
        // Connection Validation
        guard Reachability().isConnected() else {
            
            if logActivity { print(messages.noConnection) }
            return completion(false, false, nil)
        }
        
        // Prepare request
        let session = URLSession.shared
        guard let request = buildRequest(to: path, method: method, encoding: encoding, headers: headers, queryParams: queryParams, body: body) else {
            
            if logActivity { print(messages.requestGenerationFailed) }
            return completion(true, false, nil)
        }
        
        print("URL:", request.url!)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // Log
            if logActivity {
                
                print("--------------- Server Response ----------------")
                print("Response code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                print(String(data: data ?? Data(), encoding: String.Encoding.utf8) ?? "")
                print("--------------- --------------- ----------------")
            }
            
            if let _response = response as? HTTPURLResponse, _response.statusCode == 200 {
                
            }
            
            // Validation
            if let _error = error {
                
                if logActivity {
                    
                    print(self.messages.badServerResponse, "\n\n")
                    print(_error)
                }
                completion(true, false, nil)
            }
            
            // Notify parent with response data
            completion(true, true, data)
        }
        task.resume()
    }
}
