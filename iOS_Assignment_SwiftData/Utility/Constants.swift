//
//  Constants.swift
//  iOS_Assignment_SwiftData
//
//  Created by Muthuraman Vairavan on 29/08/24.
//

import Foundation

struct Constants {
    static let maxImageToLoad = 15
}

struct URLKeys {
    static let domainName = "https://api.pexels.com/v1/"
    static let APIKey = "5RBC908a5DunVnFSrIuBgt9FKvGAtxbsOUps2SzcjRDj1DSZRDbwgi1z"
}

enum errorTypes: Error {
    case urlRequestError
    case mockJsonDecoderError
}
