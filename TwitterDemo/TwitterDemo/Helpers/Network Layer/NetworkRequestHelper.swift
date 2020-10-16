//
//  NetworkRequestHelper.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 15/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    
    var name: String {
        return self.rawValue
    }
}

public enum HTTPEncoding {
    
    case queryUrl, json
}

func generateRequestBody(from params: Parameters) -> Data {
    
    // Preapre Query URL
    var body = Data()
    if params.count > 0 {
        do {
            body = try JSONSerialization.data(withJSONObject: params, options: [])
            return body
        } catch {
            
            print(Messages().requestBodyGenerationFailed)
            return body
        }
    }
    return body
}

func generateRequestBody<T: Codable>(from params: T) -> Data {
    
    // Preapre Query URL
    var body = Data()
    do {
        body = try JSONEncoder().encode(params)
        return body
    } catch {
        
        print(Messages().requestBodyGenerationFailed)
        return body
    }
}
