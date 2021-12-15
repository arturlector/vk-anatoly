//
//  Friend.swift
//  vk-anatoly
//
//  Created by Artur Igberdin on 08.12.2021.
//

import Foundation

// MARK: - Friend (DTO) - Data Transfer Object, DAO - объектс связанный с Базой данных
struct FriendDTO: Codable {
    let canAccessClosed: Bool?
    let id: Int
    let photo100: String
    let lastName, trackCode: String
    let isClosed: Bool?
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
}
