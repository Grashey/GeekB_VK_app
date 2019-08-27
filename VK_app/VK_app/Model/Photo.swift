//
//  Photo.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 27/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import SwiftyJSON

class FriendsPhoto {
    let id: Int
    let photoUrl: String
    let photoMaxUrl: String
    
    init (_ json: JSON) {
        self.id = json["id"].intValue
        self.photoUrl = json["sizes"][0]["url"].stringValue
        
        let sizesArray = json["sizes"].arrayValue
        let maxIndex = sizesArray.count - 1
        self.photoMaxUrl = json["sizes"][maxIndex]["url"].stringValue
    }
}
