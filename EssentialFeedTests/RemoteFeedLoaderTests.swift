//
//  RemoteFeedLoaderTests.swift
//  RemoteFeedLoaderTests
//
//  Created by Yevhenii Veretennikov on 29.05.2023.
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    

}
