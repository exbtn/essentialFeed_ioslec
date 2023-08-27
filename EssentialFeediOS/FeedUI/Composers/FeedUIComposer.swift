//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Yevhenii Veretennikov on 27.08.2023.
//

import EssentialFeed

public final class FeedUIComposer {
    
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let refreshController = FeedRefreshViewController(feedLoader: feedLoader)
        let feedController = FeedViewController(refreshController: refreshController)
        refreshController.onRefresh = { [weak feedController] feed in
            feedController?.tableModel = feed.map { FeedImageCellController(model: $0, imageLoader: imageLoader) }
        }
        return feedController
    }
    
}
