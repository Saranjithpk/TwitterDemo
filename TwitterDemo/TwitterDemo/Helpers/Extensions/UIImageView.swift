//
//  UIImageView.swift
//  GitHub
//
//  Created by Saranjith Pk on 15/10/20.
//  Copyright © 2020 Saranjith Saranjith Inc. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadFromLink(link: String, contentMode: UIView.ContentMode, completionHandler: @escaping () -> Void) {
        guard let url = URL(string: link) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode = contentMode
                if let data = data {
                    self.image = UIImage(data: data)
                    completionHandler()
                }
            }
        }).resume()
    }
}
