//
//  GetGroupDataOperation.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 13.10.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import Foundation
import Alamofire

class GetGroupData: AsyncOperation {
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    private var request: DataRequest
    var data: Data?
    
    override func main() {
        request.responseData(queue: .global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    init(request: DataRequest) {
        self.request = request
    }
}
