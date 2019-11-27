//
//  NetworkService.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 16/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

class NetworkService {
    
    public let dispatchGroup = DispatchGroup()
    
    func getFriends() -> Promise<[Friend]> {
        
        let url = "https://api.vk.com/method/friends.get"
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "fields" : "photo_100"
        ]
        
        return Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON()
            .map(on: .global()) { json, response in
                
                let json = JSON(json)

                if let errorMessage = json["error"]["error_msg"].string {
                    let error = NetworkError.JsonError(message: errorMessage)
                    throw error
                }
                
                let friendJSONs = json["response"]["items"].arrayValue
                return friendJSONs.map { Friend($0) }
            }
        }
  
    func getPhotos(userId: String, completion: @escaping ([Photo]) -> Void){
        
        let url = "https://api.vk.com/method/photos.getAll"
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "owner_id" : userId,
            "count" : 200,
            "offset" : 0
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { responce in
            switch responce.result {
            case .success(let data):
                let json = JSON(data)
                let photoJSON = json["response"]["items"].arrayValue
                let photos = photoJSON.map { Photo($0, ownerId: userId) }
                completion(photos)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getGroups(completion: @escaping ([Group]) -> Void){
        
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "extended" : 1
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { responce in
            switch responce.result {
            case .success(let data):
                let json = JSON(data)
                let groupJSONs = json["response"]["items"].arrayValue
                let groups = groupJSONs.map { Group($0) }
                completion(groups)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func groupSearch(searchtext: String){
        
        let url = "https://api.vk.com/method/groups.search"
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "q" : searchtext
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { responce in
            print("search for groups: \(searchtext)")
            print(responce.value!)
        }
    }
    
    func getPopularGroups(completion: @escaping ([Group]) -> Void){
        
        let url = "https://api.vk.com/method/groups.getCatalog"
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "category_id" : 0
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            responce in
            switch responce.result {
            case .success(let data):
                let json = JSON(data)
                let groupJSONs = json["response"]["items"].arrayValue
                let groups = groupJSONs.map { Group($0) }
                completion(groups)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getNewsfeed(groupId: Any, startTime: Int? = nil, startFrom: String? = nil, completion: @escaping ([News],[NewsGroup],[NewsProfile], String) -> Void) {
        
        let url = "https://api.vk.com/method/newsfeed.get"
        var parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "source_ids" : groupId,
            "filter" : "post"
        ]
        
        if let startTime = startTime {
            parameters["start_time"] = "\(startTime)"
        }
        
        if let startFrom = startFrom {
            parameters["start_from"] = "\(startFrom)"
        }
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(queue: DispatchQueue.global()) { responce in
            switch responce.result {
            case .success(let data):
                var postNews = [News]()
                var groups = [NewsGroup]()
                var profiles = [NewsProfile]()
                var nextFrom = String()
                
                DispatchQueue.global().async(group: self.dispatchGroup) {
                    let json = JSON(data)
                    let newsJSONs = json["response"]["items"].arrayValue
                    let news = newsJSONs.map { News($0) }
                    postNews = news.filter { $0.type == "post" }
                    nextFrom = json["response"]["next_from"].stringValue
                }
                
                DispatchQueue.global().async(group: self.dispatchGroup) {
                    let json = JSON(data)
                    let groupJSONs = json["response"]["groups"].arrayValue
                    groups = groupJSONs.map { NewsGroup($0) }
                }
                
                DispatchQueue.global().async(group: self.dispatchGroup) {
                    let json = JSON(data)
                    let profileJSONs = json["response"]["profiles"].arrayValue
                    profiles = profileJSONs.map { NewsProfile($0) }
                }
                
                self.dispatchGroup.notify(queue: .main) {
                    completion(postNews, groups, profiles, nextFrom)
                }
                
            case .failure(let error):
                print(error)
                completion([],[],[],"")
            }
        }
    }
}
