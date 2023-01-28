//
//  UIImageView_Loading.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 11/01/2023.
//

import Foundation
import UIKit

protocol URLImageLoaderProtocol {
    func getImage(from urlString: String) async -> UIImage?
}

class URLImageLoader: URLImageLoaderProtocol {
    func getImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else {
            return nil
        }

        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
}

extension UIImageView {
    var activityIndicator: UIActivityIndicatorView {
        get {
            let activityIndicatorView = UIActivityIndicatorView()
            return activityIndicatorView
        }
    }
    
    func setImage(from urlString: String, imageLoader: URLImageLoaderProtocol = URLImageLoader()) {
        Task {
            let image = await imageLoader.getImage(from: urlString)
            self.image = image
        }
    }
}
