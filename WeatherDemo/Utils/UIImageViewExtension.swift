//
//  UIImageViewExtension.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 11/01/2023.
//

import Foundation
import UIKit

extension UIImageView {    
    func setImage(from urlString: String, imageLoader: URLImageLoading) {
        Task {
            let image = await imageLoader.getImage(from: urlString)
            self.image = image
        }
    }
}
