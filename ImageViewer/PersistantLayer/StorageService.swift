//
//  FavoritePhotosRepository.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit
import RealmSwift

final class StorageService {
    
    private let realm: Realm?
    
    init() {
        self.realm = try? Realm()
    }
    
    func saveOrUpdateObject(object: Object) throws {
        guard let realm else { return }
        try? realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func delete(object: Object) throws {
        guard let realm else { return }
        try realm.write {
            realm.add(object, update: .all)
            realm.delete(object)
        }
    }
    
    func deleteAll() throws {
        guard let realm else { return }
        try realm.write {
            realm.deleteAll()
        }
    }
    
    func fetch<T: Object>(by type: T.Type) -> [T] {
        guard let realm else { return [] }
        return realm.objects(T.self).reversed()
    }
    
    func isObjectExist<T: Object>(by type: T.Type, with id: String) -> Bool {
        guard let realm else { return false }
        if let _ = realm.object(ofType: type.self,
                                forPrimaryKey: id) {
            return true
        }
        return false
    }
}
