//
//  MockNetworkManager.swift
//  iOS_Assignment_SwiftData
//
//  Created by Muthuraman Vairavan on 30/08/24.
//

import Foundation

class MockNetworkManager: NetworkService {
    
    func fecthPhotosAPI(url: URL) async throws -> Result<PhotoListDecodable,Error> {
        do {
            if let data = MockData.photoApiResponse.data(using: .utf8){
                return try handleResponse(data: data)
            }
            return .failure(errorTypes.mockJsonDecoderError)
        } catch {
            return .failure(error)
        }
    }
    
    func handleResponse(data: Data) throws -> Result<PhotoListDecodable,Error> {
        do {
            let photosModel = try JSONDecoder().decode(PhotoListDecodable.self, from: data)
            return .success(photosModel)
        } catch {
            return .failure(error)
        }
    }
}
