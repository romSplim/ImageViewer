//
//PersistedPhoto.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import Foundation
import RealmSwift

final class PersistedPhoto: Object {
    
    //MARK: - Properties
    @Persisted(primaryKey: true) var id: String
    @Persisted var createdAt: String
    @Persisted var url: String?
    @Persisted var user: UserPersisted?
    @Persisted var downloads: Int?
    
    //MARK: - Init
    convenience init(id: String,
                     createdAt: String,
                     url: String? = nil,
                     user: UserPersisted? = nil,
                     downloads: Int? = nil) {
        
        self.init()
        
        self.id = id
        self.createdAt = createdAt
        self.url = url
        self.user = user
        self.downloads = downloads
    }
}

final class UserPersisted: EmbeddedObject {
    
    //MARK: - Properties
    @Persisted var id: String
    @Persisted var username: String
    
    //MARK: - Init
    convenience init(id: String,
                     username: String) {
        
        self.init()
        self.id = id
        self.username = username
    }
}

//MARK: - Mapping init
extension PersistedPhoto {
    convenience init(_ dto: PhotoItem) {
        self.init()
        id = dto.id ?? ""
        createdAt = dto.createdAt ?? ""
        url = dto.urls?.regular ?? ""
        user = UserPersisted(id: dto.user?.id ?? "",
                             username: dto.user?.username ?? "")
    }
}
