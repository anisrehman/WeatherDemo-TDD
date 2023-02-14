//
//  UIImageViewPubExtension.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 13/02/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(from urlString: String) {
        self.setImage(from: urlString, imageLoader: URLImageLoader())
    }
}
