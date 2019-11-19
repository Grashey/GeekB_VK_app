//
//  Friend.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class Friend: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var surname: String = ""
    @objc dynamic var avatar: String = ""
    let photos = List<Photo>()
    
    convenience init (_ json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["first_name"].stringValue
        self.surname = json["last_name"].stringValue
        self.avatar = json["photo_100"].stringValue
        self.photos.append(objectsIn: photos)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
