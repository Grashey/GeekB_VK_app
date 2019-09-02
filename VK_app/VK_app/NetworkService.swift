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

class NetworkService {
    
    func getFriends(completion: @escaping ([Friend]) -> Void){
        
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "fields" : "photo_100"
        ]
        
        AF.request("https://api.vk.com/method/friends.get", method: .get, parameters: parameters).responseJSON {
            responce in
            switch responce.result {
            case .success(let data):
                let json = JSON(data)
                let friendJSONs = json["response"]["items"].arrayValue
                let friends = friendJSONs.map { Friend($0) }
                completion(friends)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getFriendsPhotos(userId: String, completion: @escaping ([Photo]) -> Void){
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "owner_id" : userId,
            "count" : 200,
            "offset" : 0
        ]
        
        AF.request("https://api.vk.com/method/photos.getAll", method: .get, parameters: parameters).responseJSON {
            responce in
            switch responce.result {
            case .success(let data):
                let json = JSON(data)
                let photoJSON = json["response"]["items"].arrayValue
                let photos = photoJSON.map {Photo($0)}
                completion(photos)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getGroups(completion: @escaping ([Group]) -> Void){
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "extended" : 1
        ]
        
        AF.request("https://api.vk.com/method/groups.get", method: .get, parameters: parameters).responseJSON {
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
    
    func groupSearch(searchtext: String){
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "q" : searchtext
        ]
        
        AF.request("https://api.vk.com" + "/method/groups.search", method: .get, parameters: parameters).responseJSON { responce in
            print("search for groups: \(searchtext)")
            print(responce.value!)
        }
    }
    
    func getPopularGroups(completion: @escaping ([Group]) -> Void){
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "category_id" : 0
        ]
        
        AF.request("https://api.vk.com/method/groups.getCatalog", method: .get, parameters: parameters).responseJSON {
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
    
    func getNewsfeed(groupId: Any, completion: @escaping ([News]) -> Void) {
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "source_ids" : groupId,
            "filter" : "post"
        ]
        
        AF.request("https://api.vk.com/method/newsfeed.get", method: .get, parameters: parameters).responseJSON {
            responce in
            switch responce.result {
            case .success(let data):
                let json = JSON(data)
                let newsJSONs = json["response"]["items"].arrayValue
                let news = newsJSONs.map { News($0) }
                let postNews = news.filter { $0.type == "post" }
                postNews.forEach{ print($0.groupId)}
                completion(postNews)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}
