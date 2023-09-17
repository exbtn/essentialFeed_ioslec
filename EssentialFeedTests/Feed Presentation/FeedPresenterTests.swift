//
//  FeedPresenterTests.swift
//  EssentialFeedTests
//
//  Created by Yevhenii Veretennikov on 17.09.2023.
//

import XCTest

struct FeedErorrViewModel {
    let message: String?
    
    static var noError: FeedErorrViewModel { FeedErorrViewModel(message: .none) }
}

protocol FeedErrorView {
    func display(_ viewModel: FeedErorrViewModel)
}

final class FeedPresenter {
    private let errorView: FeedErrorView
    
    init(errorView: FeedErrorView) {
        self.errorView = errorView
    }
    
    func didStartLoadingFeed() {
        errorView.display(.noError)
    }
}

final class FeedPresenterTests: XCTestCase {
    
    func test_init_doesNotSendMessagesToView() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    func test_didStartLoadingFeed_displaysNoErrorMessage() {
        let (sut, view) = makeSUT()
        
        sut.didStartLoadingFeed()
        
        XCTAssertEqual(view.messages, [.display(errorMessage: .none)])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedPresenter, view: ViewSpy) {
        let view = ViewSpy()
        let sut = FeedPresenter(errorView: view)
        trackForMemoryLeak(view, file: file, line: line)
        trackForMemoryLeak(sut, file: file, line: line)
        return (sut, view)
    }
    
    private class ViewSpy: FeedErrorView {
        enum Messages: Equatable {
            case display(errorMessage: String?)
        }
        
        private(set) var messages = [Messages]()
        
        func display(_ viewModel: FeedErorrViewModel) {
            messages.append(.display(errorMessage: viewModel.message))
        }
    }
    
}
