//
//  FeedViewController.swift
//  Prototype
//
//  Created by Yevhenii Veretennikov on 05.07.2023.
//

import UIKit

struct FeedImageViewModel {
    let description: String?
    let location: String?
    let imageName: String
}

final class FeedViewController: UITableViewController {
    private let feed = FeedImageViewModel.prototype
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = feed[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedImageCell") as! FeedImageCell
        cell.configure(with: model)
        return cell
    }
    
}

extension FeedImageCell {
    func configure(with model: FeedImageViewModel) {
        locationLabel.text = model.location
        locationContainer.isHidden = model.location == nil

        descriptionLabel.text = model.description
        descriptionLabel.isHidden = model.description == nil
        
        fadeIn(UIImage(named: model.imageName))
    }
}
