//
//  PhotoAPIClient.swift
//  iOS_Assignment_SwiftData
//
//  Created by Muthuraman Vairavan on 30/08/24.
//

import Foundation

class PhotoAPIClient {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPhoto(url: URL) async throws -> Result<PhotoListDecodable,Error> {
        return try await self.networkService.fecthPhotosAPI(url: url)
    }
}
