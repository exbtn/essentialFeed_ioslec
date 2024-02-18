//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 18.02.2024.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>
    
    func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.Result) -> Void)
}
