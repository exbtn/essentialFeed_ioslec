//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Yevhenii Veretennikov on 27.08.2023.
//

import EssentialFeed

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool { location != nil }
}
