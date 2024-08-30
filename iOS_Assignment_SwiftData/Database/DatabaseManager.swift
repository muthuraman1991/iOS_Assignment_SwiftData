//
//  DatabaseManager.swift
//  iOS_Assignment_SwiftData
//
//  Created by Muthuraman Vairavan on 29/08/24.
//

import Foundation
import SwiftUI
import SwiftData

class DatabaseManager {
    var modelContext: ModelContext?
    
    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }
    
    func fetchDataFromDB(forCategory: String) throws -> [PhotoInfoModel]?  {
        let categoryModel = #Predicate <PhotoInfoModel> { model in
            return model.category == forCategory
        }
        let descriptor = FetchDescriptor<PhotoInfoModel>(predicate: categoryModel)
        do {
            let filterModel = try modelContext?.fetch(descriptor)
            return filterModel
        } catch {
            print("error ==== \(error)")
            throw error
        }
    }
    
    func savePhotoData(forCategory: String, photoListDecodable: PhotoListDecodable) throws {
        if let photos = photoListDecodable.photos {
            for photo in photos {
                let photoInfoModel = PhotoInfoModel(model: photo, category: forCategory)
                modelContext?.insert(photoInfoModel)
            }
            do {
                try modelContext?.save()
            } catch {
                print(error.localizedDescription)
                throw error
            }
        }
    }
}
