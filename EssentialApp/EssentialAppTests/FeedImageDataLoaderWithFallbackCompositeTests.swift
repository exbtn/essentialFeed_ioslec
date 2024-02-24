//
//  FeedImageDataLoaderWithFallbackCompositeTests.swift
//  EssentialAppTests
//
//  Created by Yevhenii Veretennikov on 24.02.2024.
//

import XCTest
import EssentialFeed

class FeedImageDataLoaderWithFallbackComposite: FeedImageDataLoader {
    
    private let primary: FeedImageDataLoader
    private let fallback: FeedImageDataLoader
    
    init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        primary.loadImageData(from: url) { [weak self] result in
            switch result {
            case .failure:
                _ = self?.fallback.loadImageData(from: url, completion: completion)
                
            case .success:
                completion(result)
            }
        }
    }
}

final class FeedImageDataLoaderWithFallbackCompositeTests: XCTestCase {
    
    func test_load_deliversPrimaryImageDataOnPrimaryLoaderSuccess() {
        let primaryData = Data("primary".utf8)
        let fallbackData = Data("fallback".utf8)
        let url = anyURL()
        let sut = makeSUT(primaryResult: .success(primaryData), fallbackResult: .success(fallbackData))
        
        
        let exp = expectation(description: "Wait for load completion")
        _ = sut.loadImageData(from: url) { receivedResult in
            switch receivedResult {
            case let .success(receivedData):
                XCTAssertEqual(receivedData, primaryData)
                
            default:
                XCTFail("Expected successful image data, got \(receivedResult) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    func test_load_deliversFallbackImageDataOnPrimaryLoaderFailure() {
        let primaryError = anyNSError()
        let fallbackData = Data("fallback".utf8)
        let url = anyURL()
        let sut = makeSUT(primaryResult: .failure(primaryError), fallbackResult: .success(fallbackData))
        
        
        let exp = expectation(description: "Wait for load completion")
        _ = sut.loadImageData(from: url) { receivedResult in
            switch receivedResult {
            case let .success(receivedData):
                XCTAssertEqual(receivedData, fallbackData)
                
            default:
                XCTFail("Expected successful image data, got \(receivedResult) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(primaryResult: FeedImageDataLoader.Result, fallbackResult: FeedImageDataLoader.Result, file: StaticString = #file, line: UInt = #line) -> FeedImageDataLoader {
        let primaryLoader = ImageDataLoaderStub(result: primaryResult)
        let fallbackLoader = ImageDataLoaderStub(result: fallbackResult)
        let sut = FeedImageDataLoaderWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)
        trackForMemoryLeak(primaryLoader, file: file, line: line)
        trackForMemoryLeak(fallbackLoader, file: file, line: line)
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
    
    private class ImageDataLoaderStub: FeedImageDataLoader {
        private let result: FeedImageDataLoader.Result
        
        private struct Task: FeedImageDataLoaderTask {
            func cancel() {}
        }
        
        init(result: FeedImageDataLoader.Result) {
            self.result = result
        }
        
        func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
            completion(result)
            return Task()
        }
    }

    func trackForMemoryLeak(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should be deallocated. Potential memory leak.", file: file, line: line)
        }
    }
    
    func anyURL() -> URL {
        return URL(string: "https://a-url.com")!
    }
    
    func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}
