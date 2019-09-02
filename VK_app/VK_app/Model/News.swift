//
//  News.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 26/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class News: Object {
    @objc dynamic var groupId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var date: Int = 0
    @objc dynamic var photo: String = ""
    @objc dynamic var type: String = ""
    
    
    convenience init (_ json: JSON) {
        self.init()
        
        let sizesArray = json["attachments"][0]["photo"]["sizes"].arrayValue
        let maxIndex = sizesArray.count - 1
        
        self.groupId = -json["source_id"].intValue
        self.name = json["name"].stringValue // check
        self.avatar = json["photo_100"].stringValue // check
        self.type = json["type"].stringValue
        self.text = json["text"].stringValue
        self.date = json["date"].intValue
        self.photo = json["attachments"][0]["photo"]["sizes"][maxIndex]["url"].stringValue
    }
}
