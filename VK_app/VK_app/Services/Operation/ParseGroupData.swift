//
//  ParseGroupDataOperation.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 13.10.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseGroupData: Operation {
    
    var outputData: [Group]?
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetGroupData,
            let data = getDataOperation.data else { return }
            let json = JSON(data)
            let groupJSONs = json["response"]["items"].arrayValue
            outputData = groupJSONs.map { Group($0) }
    }
}
