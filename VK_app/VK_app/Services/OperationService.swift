//
//  OperationService.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 08.10.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class OperationService: Operation {
    
    enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
}

class GetGroupDataOperation: OperationService {
    
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

class ParseGroupData: OperationService {
    
    var outputData: [Group]?
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetGroupDataOperation,
            let data = getDataOperation.data else { return }
            let json = JSON(data)
            let groupJSONs = json["response"]["items"].arrayValue
            outputData = groupJSONs.map { Group($0) }
        self.state = .finished
    }
}

class SaveGroupData: OperationService {
    
    override func main() {
        guard let parseData = dependencies.first as? ParseGroupData,
            let parsedData = parseData.outputData else { return }
            try? RealmService.saveData(objects: parsedData)
        self.state = .finished
    }
}

class LoadGroupData: OperationService {
    
    var data: Results<Group>?
    
    override func main() {
      data = try? RealmService.getData(type: Group.self)
        self.state = .finished
    }
}
