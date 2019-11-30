//
//  RealmService.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 30/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import RealmSwift

class RealmService {
    
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func saveData<T: Object>(objects: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy = .modified) throws {
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.add(objects, update: update)
            }
        print(configuration.fileURL ?? "")
    }
        
    static func getData<T: Object>(type: T.Type,
        configuration: Realm.Configuration = deleteIfMigration) throws -> Results<T> {
            let realm = try Realm(configuration: configuration)
            return realm.objects(type)
    }
    
    static func linkPhotosToFriend(userId: Int, photos: [Photo],
        configuration: Realm.Configuration = deleteIfMigration) throws {
        let realm = try Realm(configuration: configuration)
        let friend = realm.objects(Friend.self).filter("id == [cd] %@", userId)
        for object in friend {
            let newPhotos = photos.filter{!object.photos.contains($0)}
            try realm.write {
                object.photos.append(objectsIn: newPhotos)
            }
        }
    }
}
