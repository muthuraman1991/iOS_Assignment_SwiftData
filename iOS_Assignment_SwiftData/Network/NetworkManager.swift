//
//  NetworkManager.swift
//  iOS_Assignment
//
//  Created by Muthuraman Vairavan on 28/08/24.
//

import Foundation

class NetworkManager: NetworkService {
    
    func fecthPhotosAPI(url: URL) async throws -> Result<PhotoListDecodable,Error> {
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue(URLKeys.APIKey, forHTTPHeaderField: "Authorization")
            let (data,urlResponse) = try await URLSession.shared.data(for: urlRequest)
            return try handleResponse(data: data, urlResponse: urlResponse)
        } catch {
            return .failure(error)
        }
    }
    
    func handleResponse(data: Data, urlResponse: URLResponse) throws -> Result<PhotoListDecodable,Error> {
        do {
            let photosModel = try JSONDecoder().decode(PhotoListDecodable.self, from: data)
            guard
                let urlRespone = urlResponse as? HTTPURLResponse,
                urlRespone.statusCode >= 200 && urlRespone.statusCode < 300 else {
                return .failure(errorTypes.urlRequestError)
            }
            return .success(photosModel)
        } catch {
            return .failure(error)
        }
    }
}
