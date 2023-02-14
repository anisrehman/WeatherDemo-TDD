//
//  URLImageLoader.swift
//  WeatherDemo
//
//  Created by Anis Rehman on 13/02/2023.
//

import Foundation
import UIKit

protocol URLImageLoading {
    func getImage(from urlString: String) async -> UIImage?
}

class URLImageLoader: URLImageLoading {
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
