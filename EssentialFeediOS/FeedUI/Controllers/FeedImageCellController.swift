//
//  FeedImageCellController.swift
//  EssentialFeediOS
//
//  Created by Yevhenii Veretennikov on 27.08.2023.
//

import UIKit
import EssentialFeed

public protocol FeedImageCellControllerDelegate {
    func didRequestImage()
    func didCancelImageRequest()
}

public final class FeedImageCellController: FeedImageView {
    
    private let delegate: FeedImageCellControllerDelegate
    private var cell: FeedImageCell?
    
    public init(delegate: FeedImageCellControllerDelegate) {
        self.delegate = delegate
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        delegate.didRequestImage()
        return cell!
    }
    
    func preload() {
        delegate.didRequestImage()
    }
    
    func cancelLoad() {
        releaseCellForReuse()
        delegate.didCancelImageRequest()
    }
    
    public func display(_ viewModel: FeedImageViewModel<UIImage>) {
        cell?.locationContainer.isHidden = !viewModel.hasLocation
        cell?.locationLabel.text = viewModel.location
        cell?.descriptionLabel.text = viewModel.description
        cell?.feedImageView.setAnimated(viewModel.image)
        viewModel.isLoading ? cell?.feedImageContainer.startShimmering() : cell?.feedImageContainer.stopShimmering()
        cell?.feedImageRetryButton.isHidden = !viewModel.shouldRetry
        cell?.onRetry = { [weak self] in
            self?.delegate.didRequestImage()
        }
        cell?.onReuse = { [weak self] in
            self?.releaseCellForReuse()
        }
    }
    
    func didEndDisplaying() {
        cell = nil
        delegate.didCancelImageRequest()
    }
    
    func willDisplayCell(_ cell: UITableViewCell) {
        self.cell = cell as? FeedImageCell
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
}
