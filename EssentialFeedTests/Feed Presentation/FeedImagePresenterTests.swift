//
//  FeedImagePresenterTests.swift
//  EssentialFeedTests
//
//  Created by Yevhenii Veretennikov on 17.09.2023.
//

import XCTest

final class FeedImagePresenter {
    init(view: Any) {
        
    }
}

final class FeedImagePresenterTests: XCTestCase {
    
    func test_init_doesNotSendMessagesToView() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty, "Expect no view messages")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedImagePresenter, view: ViewSpy) {
        let view = ViewSpy()
        let sut = FeedImagePresenter(view: view)
        trackForMemoryLeak(view)
        trackForMemoryLeak(sut)
        return (sut, view)
    }
    
    private class ViewSpy {
        let messages = [Any]()
    }
    
}
