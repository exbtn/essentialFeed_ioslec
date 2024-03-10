//
//  InMemoryFeedStore.swift
//  EssentialAppTests
//
//  Created by Yevhenii Veretennikov on 10.03.2024.
//

import Foundation
import EssentialFeed

class InMemoryFeedStore: FeedStore, FeedImageDataStore {
    private(set) var feedCache: CacheFeed?
    private var feedImageDataCache: [URL: Data] = [:]
    
    private init(feedCache: CacheFeed? = nil) {
        self.feedCache = feedCache
    }
}

extension InMemoryFeedStore {
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        feedCache = nil
        completion(.success(()))
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        feedCache = CacheFeed(feed: feed, timestamp: timestamp)
        completion(.success(()))
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.success(feedCache))
    }
}

extension InMemoryFeedStore {
    func insert(_ data: Data, for url: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        feedImageDataCache[url] = data
        completion(.success(()))
    }
    
    func retrieve(dataForURL url: URL, completion: @escaping (Result<Data?, Error>) -> Void) {
        completion(.success(feedImageDataCache[url]))
    }
}

extension InMemoryFeedStore {
    static var empty: InMemoryFeedStore {
        InMemoryFeedStore()
    }
    
    static var withExpiredFeedCache: InMemoryFeedStore {
        InMemoryFeedStore(feedCache: CacheFeed(feed: [], timestamp: Date.distantPast))
    }
    
    static var withNonExpiredFeedCache: InMemoryFeedStore {
        InMemoryFeedStore(feedCache: CacheFeed(feed: [], timestamp: Date()))
    }
}
