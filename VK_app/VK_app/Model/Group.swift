//
//  Groups.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 07/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift


class Group: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    
    convenience init (_ json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.avatar = json["photo_100"].stringValue
    }
}
//
//struct Group {
//    let name: String
//    let avatar: UIImage?
//}
//var groups = [
//    Group(name: "MIB", avatar: UIImage(named: "GroupMIB")),
//    Group(name: "Be Happy", avatar: UIImage(named: "GroupSmile")),
//    Group(name: "Cinema", avatar: UIImage(named: "Group3D")),
//    Group(name: "Will Smith Fan Zone", avatar: UIImage(named: "GroupWillSmith")),
//    Group(name: "Shit Happens", avatar: UIImage(named: "GroupMonster")),
//    Group(name: "Angry Birds Community", avatar: UIImage(named: "GroupAngryBirds")),
//    Group(name: "Engineering", avatar: UIImage(named: "GroupLabirint")),]

//    var allGroups = [
//        Group(name: "Mortal Combat", avatar: UIImage(named: "GroupMortalCombat")),
//        Group(name: "Funny Bunnies", avatar: UIImage(named: "GroupBunny")),
//        Group(name: "Euphoria", avatar: UIImage(named: "GroupDrugs")),
//        Group(name: "Hulk Fan Club", avatar: UIImage(named: "GroupHulk")),
//        Group(name: "Video Games", avatar: UIImage(named: "GroupMinion")),
//        Group(name: "Hackers", avatar: UIImage(named: "GroupRadiation")),
//        Group(name: "Passion", avatar: UIImage(named: "GroupLips")),
//        Group(name: "MIB", avatar: UIImage(named: "GroupMIB")),
//        Group(name: "Be Happy", avatar: UIImage(named: "GroupSmile")),
//        Group(name: "Cinema", avatar: UIImage(named: "Group3D")),
//        Group(name: "Will Smith Fan Zone", avatar: UIImage(named: "GroupWillSmith")),
//        Group(name: "Shit Happens", avatar: UIImage(named: "GroupMonster")),
//        Group(name: "Angry Birds Community", avatar: UIImage(named: "GroupAngryBirds")),
//        Group(name: "Engineering", avatar: UIImage(named: "GroupLabirint")),]
