//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 01.06.2023.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case error(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
