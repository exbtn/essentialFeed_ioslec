//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 29.05.2023.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
