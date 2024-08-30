//
//  PhotoInfoModel.swift
//  iOS_Assignment_SwiftData
//
//  Created by Muthuraman Vairavan on 28/08/24.
//

import Foundation
import SwiftData

@Model
final class PhotoInfoModel {
    @Attribute(.unique) let id: Int?
    let width: Int?
    let height: Int?
    let url: String?
    let photographer: String?
    let photographer_url: String?
    let photographer_id: Int?
    let avg_color: String?
    let src: [String: String]?
    let liked: Bool?
    let alt: String?
    let category: String
    
    init(id: Int?, width: Int?, height: Int?, url: String?, photographer: String?, photographer_url: String?, photographer_id: Int?, avg_color: String?, src: [String : String]?, liked: Bool?, alt: String?, category: String) {
        self.id = id
        self.width = width
        self.height = height
        self.url = url
        self.photographer = photographer
        self.photographer_url = photographer_url
        self.photographer_id = photographer_id
        self.avg_color = avg_color
        self.src = src
        self.liked = liked
        self.alt = alt
        self.category = category
    }
    
    init(model: PhotoInfoDecodable, category: String) {
        self.id = model.id
        self.width = model.width
        self.height = model.height
        self.url = model.url
        self.photographer = model.photographer
        self.photographer_url = model.photographer_url
        self.photographer_id = model.photographer_id
        self.avg_color = model.avg_color
        self.src = model.src
        self.liked = model.liked
        self.alt = model.alt
        self.category = category
    }
}
