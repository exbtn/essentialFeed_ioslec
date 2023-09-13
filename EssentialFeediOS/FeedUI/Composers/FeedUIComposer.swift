//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Yevhenii Veretennikov on 27.08.2023.
//

import UIKit
import EssentialFeed

public final class FeedUIComposer {
    
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let decoratedFeedLoader = MainQueueDispatchDecorator(decoratee: feedLoader)
        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: decoratedFeedLoader)
        
        let feedController = FeedViewController.makeWith(delegate: presentationAdapter, title: FeedPresenter.title)
        
        let decoratedImageLoader = MainQueueDispatchDecorator(decoratee: imageLoader)
        let feedView = FeedViewAdapter(controller: feedController, imageLoader: decoratedImageLoader)
        let loadingView = WeakRefVirtualProxy(feedController)
        
        let presenter = FeedPresenter(feedView: feedView, loadingView: loadingView)
        presentationAdapter.presenter = presenter
        
        return feedController
    }
    
}



private extension FeedViewController {
    static func makeWith(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
        feedController.delegate = delegate
        feedController.title = title
        return feedController
    }
}

private final class FeedViewAdapter: FeedView {
    
    private weak var controller: FeedViewController?
    private let imageLoader: FeedImageDataLoader
    
    init(controller: FeedViewController, imageLoader: FeedImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.tableModel = viewModel.feed.map {
            let adapter = FeedImageDataLoaderPresentationAdapter<WeakRefVirtualProxy<FeedImageCellController>, UIImage>(model: $0, imageLoader: imageLoader)
            let view = FeedImageCellController(delegate: adapter)
            
            adapter.presenter = FeedImagePresenter(
                view: WeakRefVirtualProxy(view),
                imageTransformer: UIImage.init)
            return view
        }
    }
    
}
