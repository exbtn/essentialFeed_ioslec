//
//  UIImageView+Animations.swift
//  EssentialFeediOS
//
//  Created by Yevhenii Veretennikov on 12.09.2023.
//

import UIKit

extension UIImageView {
    func setAnimated(_ newImage: UIImage?) {
        image = newImage
        
        guard newImage != nil else { return }
        
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
