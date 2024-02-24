//
//  FeedLoaderWithFallbackComposite.swift
//  EssentialApp
//
//  Created by Yevhenii Veretennikov on 24.02.2024.
//

import EssentialFeed

public class FeedLoaderWithFallbackComposite: FeedLoader {
    let primary: FeedLoader
    let fallback: FeedLoader
    
    public init(primary: FeedLoader, fallback: FeedLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        primary.load { [weak self] result in
            switch result {
            case .failure:
                self?.fallback.load(completion: completion)
                
            case .success:
                completion(result)
            }
        }
    }
}
