//
//  Friends.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Friend {
    let name: String
    let surname: String
    let avatar: UIImage?
    let photos: [UIImage?]
}

class Friends: Codable {
    let id: Int
    let name: String
    let surname: String
    let avatar: String
    
    init (_ json: JSON) {
        self.id = json["id"].intValue
        self.name = json["first_name"].stringValue
        self.surname = json["last_name"].stringValue
        self.avatar = json["photo_100"].stringValue
    }
}
