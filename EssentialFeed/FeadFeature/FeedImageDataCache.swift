//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 24.02.2024.
//

import Foundation

public protocol FeedImageDataCache {
    typealias SaveResult = Result<Void, Swift.Error>
    
    func save(_ data: Data, for url: URL, completion: @escaping (FeedImageDataCache.SaveResult) -> Void)
}
