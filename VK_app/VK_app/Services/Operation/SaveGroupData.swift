//
//  SaveGroupDataOperation.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 13.10.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import Foundation

class SaveGroupData: Operation {
    
    override func main() {
        guard let parseData = dependencies.first as? ParseGroupData,
            let parsedData = parseData.outputData else { return }
            try? RealmService.saveData(objects: parsedData)
    }
}
