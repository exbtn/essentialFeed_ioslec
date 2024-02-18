//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 01.06.2023.
//

import Foundation

final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.isOk, let root = try? JSONDecoder().decode(Root.self, from: data)
        else { throw RemoteFeedLoader.Error.invalidData }
        
        return root.items
    }
}
