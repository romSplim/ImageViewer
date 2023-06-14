//
//  c.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import Foundation
import RealmSwift

final class FavoritePhotosRepository {
    
    private let storage: StorageService
    
    init(storage: StorageService = StorageService()) {
        self.storage = storage
    }
    
    func getPhotoList() -> [PhotoItem] {
        let data = storage.fetch(by: PersistedPhoto.self)
        return data.map(PhotoItem.init)
    }
    
    func savePhoto(_ photo: PhotoItem) {
        let object = PersistedPhoto.init(photo)
        print(object)
        try? storage.saveOrUpdateObject(object: object)
    }
    
    func deletePhoto(_ photo: PhotoItem) {
        let object = PersistedPhoto(photo)
        try? storage.delete(object: object)
    }
    
    func clearPhotoList() {
        try? storage.deleteAll()
    }
    
    func isFavoritePhotoExist(with id: String) -> Bool {
        storage.isObjectExist(by: PersistedPhoto.self, with: id)
    }
}
