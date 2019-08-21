//
//  Groups.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Group {
    let name: String
    let avatar: UIImage?
}

class Groups: Codable {
    let id: Int
    let name: String
    let avatar: String
    
    init (_ json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.avatar = json["photo_100"].stringValue
    }
}
