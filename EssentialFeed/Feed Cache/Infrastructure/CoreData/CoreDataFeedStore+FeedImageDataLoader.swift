//
//  CoreDataFeedStore+FeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 18.02.2024.
//

import Foundation

extension CoreDataFeedStore: FeedImageDataStore {
    
    public func insert(_ data: Data, for url: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    public func retrieve(dataForURL url: URL, completion: @escaping (Result<Data?, Error>) -> Void) {
        completion(.success(.none))
    }
    
}
