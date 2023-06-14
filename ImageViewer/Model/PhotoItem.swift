//
//  Photo.swift
//  ImageViewer
//
//  Created by ramil on 11.06.2023.
//

import Foundation

struct PhotoItem: Decodable {
    
    var id: String?
    var createdAt: String?
    var urls: Urls?
    var user: User?
    var downloads: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case urls
        case user
        case downloads
    }
}

// MARK: - Urls
struct Urls: Decodable {
    var raw, full, regular, small: String?
    var thumb, smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

struct User: Decodable {
    let id: String
    var username: String?
}

// MARK: - ProfileImage
struct ProfileImage: Decodable {
    let small: String
    let medium: String
    let large: String
}

extension PhotoItem: Hashable {
    
    static func == (lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension PhotoItem {
    init(object: PersistedPhoto) {
        id = object.id
        createdAt = object.createdAt
        urls = Urls(regular: object.url)
        user = User(id: object.user?.id ?? "",
                    username: object.user?.username ?? "")
        downloads = object.downloads
    }
}
