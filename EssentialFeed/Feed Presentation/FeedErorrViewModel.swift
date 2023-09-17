//
//  FeedErorrViewModel.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 17.09.2023.
//

import Foundation

public struct FeedErorrViewModel {
    public let message: String?
    
    static var noError: FeedErorrViewModel {
        return FeedErorrViewModel(message: .none)
    }
    
    static func error(message: String) -> FeedErorrViewModel {
        return FeedErorrViewModel(message: message)
    }
}

public protocol FeedErrorView {
    func display(_ viewModel: FeedErorrViewModel)
}
