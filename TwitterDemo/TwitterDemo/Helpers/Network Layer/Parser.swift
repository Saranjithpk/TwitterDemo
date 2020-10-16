//
//  Parser.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 15/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

struct Parser {
    
    static func parse<T: Decodable>(_ data: Data?) -> T? {
        // Validation
        guard let _data = data else {
            if logActivity { print(Messages().emptyData) }
            return nil
        }

        // Parsing
        do {
            let modal = try JSONDecoder().decode(T.self, from: _data)
            return modal
        } catch {
            print(error)
            return nil
        }
    }
}
