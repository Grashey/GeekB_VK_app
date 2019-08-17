//
//  Session.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class Session {
    
    static let instance = Session()
    private init(){}
    
    var token = String()
    var id = Int()
}
