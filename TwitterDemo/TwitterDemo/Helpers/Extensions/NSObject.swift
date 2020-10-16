//
//  NSObject.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 15/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
