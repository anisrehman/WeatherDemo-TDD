//
//  UIImagViewTests.swift
//  WeatherDemoTests
//
//  Created by Anis Rehman on 18/01/2023.
//

import XCTest
@testable import WeatherDemo

final class UIImageViewTests: XCTestCase {
    func testImageViewFromURL() throws {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.setImage(from: "", imageLoader: MockURLImageLoader())
        let expectation = expectation(description: "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(imageView.image)
    }
}

class MockURLImageLoader: URLImageLoaderProtocol {
    func getImage(from urlString: String) async -> UIImage? {
        return UIImage(systemName: "info.circle")
    }
}
