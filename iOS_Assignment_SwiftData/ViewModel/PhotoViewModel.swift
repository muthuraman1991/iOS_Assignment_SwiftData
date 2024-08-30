//
//  PhotoViewModel.swift
//  iOS_Assignment
//
//  Created by Muthuraman Vairavan on 28/08/24.
//

import Foundation
import SwiftUI
import SwiftData

class PhotoViewModel: ObservableObject {
    @Published var photoListModel: PhotoListDecodable?
    var databaseManager: DatabaseManager?
    var selectedCategories = ""
    let categories = ["Nature", "Underwater", "Night Photography", "Animals", "Food", "Buildings", "Travel"]
    
    init(modelContext: ModelContext?) {
        databaseManager = DatabaseManager(modelContext: modelContext)
    }
    
    func fetchPhotos(forCategory: String) async throws {
        do {
            selectedCategories = forCategory
            let filterModel = try databaseManager?.fetchDataFromDB(forCategory: forCategory)
            if let photoList = filterModel?.compactMap({ convertToPhotoInfoDecodableModel(model: $0) }), !photoList.isEmpty {
                await MainActor.run {
                    photoListModel = PhotoListDecodable(photos: photoList)
                }
                return
            }
            try await fetchPhotosFromAPI(forCategory: forCategory)
        } catch {
            print("error ==== \(error)")
            throw error
        }
    }
    
    func convertToPhotoInfoDecodableModel(model: PhotoInfoModel?) -> PhotoInfoDecodable {
        return PhotoInfoDecodable(model: model)
    }
    
    func fetchPhotosFromAPI(forCategory: String) async throws {
        do {
            let photoAPIClient = PhotoAPIClient(networkService: NetworkManager())
            if let url = URL(string: URLKeys.domainName + "search?query=\(forCategory)&per_page=\(Constants.maxImageToLoad)") {
                let result = try await photoAPIClient.fetchPhoto(url: url)
                switch result {
                case .success(let photoListDecodable):
                    try await MainActor.run {
                        self.photoListModel = photoListDecodable
                        try databaseManager?.savePhotoData(forCategory: forCategory, photoListDecodable: photoListDecodable)
                    }
                    
                case .failure(let error):
                    print("error ==== \(error)")
                    throw error
                }
            }
        } catch {
            print("error ==== \(error)")
            throw error
        }
    }
}
