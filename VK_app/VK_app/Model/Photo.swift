//
//  Photo.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 27/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class Photo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var photoMaxUrl: String = ""
    let owner = List<Friend>()
    
    convenience init (_ json: JSON, ownerId: String) {
        self.init()
        
        self.id = json["id"].intValue
        self.photoUrl = json["sizes"][0]["url"].stringValue
        
        let sizesArray = json["sizes"].arrayValue
        let maxIndex = sizesArray.count - 1
        self.photoMaxUrl = json["sizes"][maxIndex]["url"].stringValue
        
        let friendsResult = try? RealmService.getData(type: Friend.self)
        let currenfFriend = friendsResult?.filter("id == %@", Int(ownerId)!)
        guard let friend = currenfFriend?.first else { return }
        self.owner.append(friend)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
