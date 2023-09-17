//
//  FeedLoadingViewModel.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 17.09.2023.
//

import Foundation

public struct FeedLoadingViewModel {
    public let isLoading: Bool
}

public protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}
