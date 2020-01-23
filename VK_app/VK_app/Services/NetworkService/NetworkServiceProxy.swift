//
//  NetworkServiceProxy.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 23.01.2020.
//  Copyright © 2020 Aleksandr Fetisov. All rights reserved.
//

import Foundation
import PromiseKit

class NetworkServiceProxy: NetworkServiceInterface {
    
    let networkService: NetworkService
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func getFriends() -> Promise<[Friend]> {
        LogAction.log(date: Date(), description: "getFriends")
        return self.networkService.getFriends()
    }
    
    func getPhotos(userId: String, startFrom: Int? = nil, completion: @escaping ([Photo]) -> Void) {
        LogAction.log(date: Date(), description: "getPhotos")
        self.networkService.getPhotos(userId: userId, startFrom: startFrom, completion: completion)
    }
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
        LogAction.log(date: Date(), description: "getGroups")
        self.networkService.getGroups(completion: completion)
    }
    
    func groupSearch(searchtext: String) {
        LogAction.log(date: Date(), description: "groupSearch")
        self.networkService.groupSearch(searchtext: searchtext)
    }
    
    func getPopularGroups(completion: @escaping ([Group]) -> Void) {
        LogAction.log(date: Date(), description: "getPopularGroups")
        self.networkService.getPopularGroups(completion: completion)
    }
    
    func getNewsfeed(groupId: Any, startTime: Int? = nil, startFrom: String? = nil, completion: @escaping ([News], [NewsGroup], [NewsProfile], String) -> Void) {
        LogAction.log(date: Date(), description: "getNewsfeed")
        self.networkService.getNewsfeed(groupId: groupId, startTime: startTime, startFrom: startFrom, completion: completion)
    }
}
