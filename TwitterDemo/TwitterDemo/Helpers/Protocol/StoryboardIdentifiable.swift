//
//  StoryboardIdentifiable.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 15/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
