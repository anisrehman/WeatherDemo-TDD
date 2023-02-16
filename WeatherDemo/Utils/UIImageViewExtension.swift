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
            let activityIndicatorView = UIActivityIndicatorView()
            activityIndicatorView.startAnimating()
            self.addSubview(activityIndicatorView)
            debugPrint(self.frame)
            let center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
            activityIndicatorView.center = center
            let image = await imageLoader.getImage(from: urlString)
            self.image = image
            activityIndicatorView.removeFromSuperview()
        }
    }
}
