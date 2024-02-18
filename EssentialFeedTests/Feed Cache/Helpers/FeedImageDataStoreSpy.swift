//
//  FeedImageDataStoreSpy.swift
//  EssentialFeedTests
//
//  Created by Yevhenii Veretennikov on 18.02.2024.
//

import Foundation
import EssentialFeed

class FeedImageDataStoreSpy: FeedImageDataStore {
    enum Message: Equatable {
        case retrieve(dataFor: URL)
        case insert(data: Data, for: URL)
    }
    
    private var completions = [(FeedImageDataStore.RetrievalResult) -> Void]()
    private(set) var receivedMessages = [Message]()
    
    func retrieve(dataForURL url: URL, completion: @escaping (Result<Data?, Error>) -> Void) {
        receivedMessages.append(.retrieve(dataFor: url))
        completions.append(completion)
    }
    
    func completeRetrieval(with error: Error, at index: Int = 0) {
        completions[index](.failure(error))
    }
    
    func completeRetrieval(with data: Data?, at index: Int = 0) {
        completions[index](.success(data))
    }
    
    func insert(_ data: Data, for url: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        receivedMessages.append(.insert(data: data, for: url))
    }
}
