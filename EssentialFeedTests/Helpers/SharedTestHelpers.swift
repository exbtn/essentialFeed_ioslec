//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Yevhenii Veretennikov on 11.06.2023.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "https://a-url.com")!
}
