//
//  NetworkService.swift
//  iOS_Assignment_SwiftData
//
//  Created by Muthuraman Vairavan on 30/08/24.
//

import Foundation

protocol NetworkService {
    func fecthPhotosAPI(url: URL) async throws -> Result<PhotoListDecodable,Error>
}
