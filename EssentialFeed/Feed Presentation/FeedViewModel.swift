//
//  FeedViewModel.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 17.09.2023.
//

import Foundation

public struct FeedViewModel {
    public let feed: [FeedImage]
}

public protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}
