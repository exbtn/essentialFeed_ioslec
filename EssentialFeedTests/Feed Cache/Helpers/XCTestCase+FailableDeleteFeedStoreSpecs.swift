//
//  XCTestCase+FailableDeleteFeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Yevhenii Veretennikov on 13.06.2023.
//

import XCTest
import EssentialFeed

extension FailableDeleteFeedStoreSpecs where Self: XCTestCase {
    func assertThatDeleteDeliversErrorOnDeletionFailure(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        let deletionError = deleteCache(from: sut, file: file, line: line)

        XCTAssertNotNil(deletionError, "Expected to cache deletion fail", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnDeletionFailure(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
        deleteCache(from: sut, file: file, line: line)

        expect(sut, toRetrieve: .empty, file: file, line: line)
    }
}
