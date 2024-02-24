//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 24.02.2024.
//

import Foundation

public protocol FeedCache {
    typealias SaveResult = Result<Void, Error>
    
    func save(_ feed: [FeedImage], completion: @escaping (FeedCache.SaveResult) -> Void)
}
