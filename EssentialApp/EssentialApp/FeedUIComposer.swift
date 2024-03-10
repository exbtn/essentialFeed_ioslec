//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Yevhenii Veretennikov on 27.08.2023.
//

import Combine
import UIKit
import EssentialFeed
import EssentialFeediOS

public final class FeedUIComposer {
    
    private init() {}
    
    public static func feedComposedWith(feedLoader: @escaping () -> FeedLoader.Publisher, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: { feedLoader().dispatchOnMainQueue() })
        
        let feedController = FeedViewController.makeWith(delegate: presentationAdapter, title: FeedPresenter.title)
        
        let decoratedImageLoader = MainQueueDispatchDecorator(decoratee: imageLoader)
        let feedView = FeedViewAdapter(controller: feedController, imageLoader: decoratedImageLoader)
        let loadingView = WeakRefVirtualProxy(feedController)
        let errorView = WeakRefVirtualProxy(feedController)
        
        let presenter = FeedPresenter(feedView: feedView, loadingView: loadingView, errorView: errorView)
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
