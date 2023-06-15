//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 29.05.2023.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
