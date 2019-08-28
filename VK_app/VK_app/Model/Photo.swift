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

class FriendsPhoto {
    @objc dynamic var id: Int = 0
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var photoMaxUrl: String = ""
    
    init (_ json: JSON) {
        self.id = json["id"].intValue
        self.photoUrl = json["sizes"][0]["url"].stringValue
        
        let sizesArray = json["sizes"].arrayValue
        let maxIndex = sizesArray.count - 1
        self.photoMaxUrl = json["sizes"][maxIndex]["url"].stringValue
    }
}

class PhotoAlbum {
    @objc dynamic var id: String = ""
    @objc dynamic var albumTitle: String = ""
    
    init(_ json: JSON) {
        self.id = json["id"].stringValue
        self.albumTitle = json["title"].stringValue
        
    }
}
