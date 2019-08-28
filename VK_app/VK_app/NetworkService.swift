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
    
    func getFriends(completion: @escaping ([MyFriend]) -> Void){
        
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
                let friends = friendJSONs.map { MyFriend($0) }
                //friends.forEach { print($0.id, $0.name, $0.surname)}
                completion(friends)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    func getPhotoAlbums(userId: String, completion: @escaping ([PhotoAlbum]) -> Void){
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "uid" : userId
        ]
        
        AF.request("https://api.vk.com/method/photos.getAlbums", method: .get, parameters: parameters).responseJSON {
            responce in
            switch responce.result {
            case .success(let data):
                let json = JSON(data)
                let photoJSON = json["response"]["items"].arrayValue
                let albums = photoJSON.map {PhotoAlbum($0)}
                albums.forEach { print($0.id, $0.albumTitle)}
                completion(albums)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getPhotos(userId: String, albumId: Any, completion: @escaping ([FriendsPhoto]) -> Void){
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token,
            "owner_id" : userId,
            "album_id" : albumId
        ]
        
        AF.request("https://api.vk.com/method/photos.get", method: .get, parameters: parameters).responseJSON {
            responce in
            switch responce.result {
            case .success(let data):
                let json = JSON(data)
                let photoJSON = json["response"]["items"].arrayValue
                let photos = photoJSON.map {FriendsPhoto($0)}
                completion(photos)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getFriendsPhotos(userId: String, completion: @escaping ([FriendsPhoto]) -> Void){
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
                let photos = photoJSON.map {FriendsPhoto($0)}
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
}
