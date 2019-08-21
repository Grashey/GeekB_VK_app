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
    
//    func sendRequest(object: String){
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/\(object).get"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "v", value: "5.96"),
//            URLQueryItem(name: "access_token", value: Session.instance.token)
//        ]
//        guard let url = urlComponents.url else { fatalError("Request url is not valid")}
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            guard let data = data else { return }
//            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
//
//            print(object)
//            print(json!)
//        }
//        task.resume()
//    }
    
    func sendRequestUserPhotos(userId: String){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(userId)"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.96")
        ]
        guard let url = urlComponents.url else { fatalError("Request url is not valid")}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            print("User's Photos")
            print(json!)
        }
        task.resume()
    }
    
    func getFriends(completion: @escaping ([myFriend]) -> Void){
        
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
                let friends = friendJSONs.map { myFriend($0) }
                friends.forEach { print($0.name)}
                completion(friends)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getGroups(completion: @escaping ([Groups]) -> Void){
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
                let groups = groupJSONs.map { Groups($0) }
                groups.forEach { print($0.name)}
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
    
}
