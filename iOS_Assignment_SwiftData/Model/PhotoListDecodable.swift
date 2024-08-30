//
//  PhotoResource.swift
//  iOS_Assignment
//
//  Created by Muthuraman Vairavan on 28/08/24.
//

import Foundation


struct PhotoListDecodable: Decodable {
    var photos: [PhotoInfoDecodable]?
}

struct PhotoInfoDecodable: Decodable {
    let id: Int?
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
}

extension PhotoInfoDecodable {
    init(model: PhotoInfoModel?) {
        self.id = model?.id
        self.width = model?.width
        self.height = model?.height
        self.url = model?.url
        self.photographer = model?.photographer
        self.photographer_url = model?.photographer_url
        self.photographer_id = model?.photographer_id
        self.avg_color = model?.avg_color
        self.src = model?.src
        self.liked = model?.liked
        self.alt = model?.alt
    }
}
