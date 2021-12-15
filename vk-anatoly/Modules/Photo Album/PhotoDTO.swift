//
//  PhotoDTO.swift
//  vk-anatoly
//
//  Created by Artur Igberdin on 15.12.2021.
//

import Foundation

// MARK: - Welcome
struct Welcome1: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [PhotoDTO]
}

// MARK: - Item
struct PhotoDTO: Codable {
    let albumID, id, date: Int
    let text: String
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    
    //Computed property
    var smallImage: String {
        guard let size = sizes.first else { return "" }
        return size.url
    }
    
    var bigImage: String {
        guard let size = sizes.last else { return "" }
        return size.url
    }

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}
