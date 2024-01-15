//
//  RemoteFeedImageDataLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Yevhenii Veretennikov on 15.01.2024.
//

import XCTest
import EssentialFeed

class RemoteFeedImageDataLoader {
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) {
        client.get(from: url)  { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            default:
                break
            }
        }
    }
}

final class RemoteFeedImageDataLoaderTests: XCTestCase {
    
    func test_init_doesNotPerformAnyURLRequest() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_loadImageDataFromURL_requestsDataFromURL() {
        let url = anyURL()
        let (sut, client) = makeSUT()
        
        sut.loadImageData(from: url) { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = anyURL()
        let (sut, client) = makeSUT()
        
        sut.loadImageData(from: url) { _ in }
        sut.loadImageData(from: url) { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        let clientError = anyNSError()
        
        expect(sut, toCompleteWith: .failure(clientError)) {
            client.complete(with: clientError)
        }
    }
    
    private func makeSUT(url: URL = anyURL(), file: StaticString = #file, line: UInt = #line) -> (sut: RemoteFeedImageDataLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedImageDataLoader(client: client)
        trackForMemoryLeak(client)
        trackForMemoryLeak(sut)
        return (sut, client)
    }
    
    private func expect(_ sut: RemoteFeedImageDataLoader, toCompleteWith result: FeedImageDataLoader.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        
        let url = URL(string: "https://a-given-url.com")!
        let exp = expectation(description: "Wait for load completion")
        sut.loadImageData(from: url) { receivedResult in
            switch (receivedResult, result) {
            case let (.success(receivedData), .success(expectedData)):
                XCTAssertEqual(receivedData, expectedData, file: file, line: line)
            case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result: \(result) got: \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 1)
    }

}
