//
//  FeedLoaderPresentationAdapter.swift
//  EssentialFeediOS
//
//  Created by Yevhenii Veretennikov on 13.09.2023.
//

import Combine
import Foundation
import EssentialFeed
import EssentialFeediOS

final class FeedLoaderPresentationAdapter: FeedViewControllerDelegate {
    private let feedLoader: () -> FeedLoader.Publisher
    private var cancellable: Cancellable?
    var presenter: FeedPresenter?
    
    init(feedLoader: @escaping () -> FeedLoader.Publisher) {
        self.feedLoader = feedLoader
    }
    
    func didRequestFeedRefresh() {
        presenter?.didStartLoadingFeed()
        
        cancellable = feedLoader().sink(
            receiveCompletion: { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.presenter?.didFinishLoadingFeed(with: error)
            },
            receiveValue: { [weak self] feed in
                self?.presenter?.didFinishLoadingFeed(with: feed)
            })
    }
}
