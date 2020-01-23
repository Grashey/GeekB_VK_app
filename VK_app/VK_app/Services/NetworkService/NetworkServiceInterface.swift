//
//  NetworkServiceInterface.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 23.01.2020.
//  Copyright © 2020 Aleksandr Fetisov. All rights reserved.
//

import Foundation
import PromiseKit

protocol NetworkServiceInterface {
    
    func getFriends() -> Promise<[Friend]>
    func getPhotos(userId: String, startFrom: Int?, completion: @escaping ([Photo]) -> Void)
    func getGroups(completion: @escaping ([Group]) -> Void)
    func groupSearch(searchtext: String)
    func getPopularGroups(completion: @escaping ([Group]) -> Void)
    func getNewsfeed(groupId: Any, startTime: Int?, startFrom: String?, completion: @escaping ([News],[NewsGroup],[NewsProfile], String) -> Void)
}
