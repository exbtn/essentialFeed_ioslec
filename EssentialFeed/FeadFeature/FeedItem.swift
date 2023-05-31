//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 29.05.2023.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
