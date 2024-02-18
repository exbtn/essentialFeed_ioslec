//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by Yevhenii Veretennikov on 18.02.2024.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOk: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
