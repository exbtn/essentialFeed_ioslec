//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by Yevhenii Veretennikov on 24.02.2024.
//

import Foundation

func anyURL() -> URL {
    return URL(string: "https://a-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyData() -> Data {
    return Data("any data".utf8)
}
