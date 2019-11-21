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
    @objc dynamic var userId: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var text: String = ""
    //@objc dynamic var photo: String = ""
    @objc dynamic var date: Int = 0
    @objc dynamic var comments: Int = 0
    @objc dynamic var likes: Int = 0
    @objc dynamic var userLikes: Int = 0
    @objc dynamic var reposts: Int = 0
    @objc dynamic var views: Int = 0
    
    var data = [String]()
    var photos = [String]()
    var aspectRatio = 1
    
    convenience init (_ json: JSON) {
        self.init()
        
        let sizesArray = json["attachments"][0]["photo"]["sizes"].arrayValue
        let maxIndex = sizesArray.count - 1
        
        if sizesArray.count > 0 {
            let height = json["attachments"][0]["photo"]["sizes"][0]["height"].intValue
            let width = json["attachments"][0]["photo"]["sizes"][0]["width"].intValue
            aspectRatio = height / width
        }
        
        let photosArray = json["attachments"].arrayValue
        let photosMaxIndex = photosArray.count - 1
        
        switch photosMaxIndex {
        case -1:
            return
        default:
            for i in 0...photosMaxIndex {
                let photo = json["attachments"][i]["photo"]["sizes"][maxIndex]["url"].stringValue
                photos.append(photo)
            }
        }
        
        self.groupId = json["source_id"].intValue
        self.userId = json["signer_id"].intValue
        self.type = json["type"].stringValue
        self.text = json["text"].stringValue
        self.date = json["date"].intValue
        self.comments = json["comments"]["count"].intValue
        self.likes = json["likes"]["count"].intValue
        self.userLikes = json["likes"]["user_likes"].intValue
        self.reposts = json["reposts"]["count"].intValue
        self.views = json["views"]["count"].intValue
        
        if !self.text.isEmpty {
            let name = "NewsTextCell"
            data.append(name)
        }
        if !self.photos.isEmpty {
            let name = "NewsPhotoCell"
            data.append(name)
        }
        if self.userId > 0 {
            let name = "NewsProfileCell"
            data.append(name)
        }
    }
}

class NewsGroup: Object {
    
    @objc dynamic var groupId: Int = 0
    @objc dynamic var groupName: String = ""
    @objc dynamic var groupAvatar: String = ""
    
    convenience init (_ json: JSON) {
        self.init()
        
        self.groupId = json["id"].intValue
        self.groupName = json["name"].stringValue
        self.groupAvatar = json["photo_100"].stringValue
    }
}

class NewsProfile: Object {
    
    @objc dynamic var userId: Int = 0
    @objc dynamic var userName: String = ""
    @objc dynamic var userSurname: String = ""
    @objc dynamic var userAvatar: String = ""
    
    convenience init (_ json: JSON) {
        self.init()
        
        self.userId = json["id"].intValue
        self.userName = json["first_name"].stringValue
        self.userSurname = json["last_name"].stringValue
        self.userAvatar = json["photo_100"].stringValue
    }
}
