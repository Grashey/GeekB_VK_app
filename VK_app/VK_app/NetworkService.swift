//
//  NetworkService.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 16/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import Alamofire

class NetworkService {
    
    func sendRequest(object: String){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/\(object).get"
        urlComponents.queryItems = [
            URLQueryItem(name: "v", value: "5.96"),
            URLQueryItem(name: "access_token", value: Session.instance.token)
        ]
        guard let url = urlComponents.url else { fatalError("Request url is not valid")}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            print(object)
            print(json!)
        }
        task.resume()
    }
    
    func sendRequestUserProfile(userId: String){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/users.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(userId)"),
            URLQueryItem(name: "fields", value: "crop_photo"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.96")
        ]
        guard let url = urlComponents.url else { fatalError("Request url is not valid")}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            print("User Profile")
            print(json!)
        }
        task.resume()
    }
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
    
    func sendRequestGroupProfile(groupId: String){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.getById"
        urlComponents.queryItems = [
            URLQueryItem(name: "group_id", value: "\(groupId)"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.96")
        ]
        guard let url = urlComponents.url else { fatalError("Request url is not valid")}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            print("Group Profile")
            print(json!)
        }
        task.resume()
    }
    
    func alamofireSendRequest(object: String){
        
        let parameters: Parameters = [
            "v" : "5.96",
            "access_token" : Session.instance.token
        ]
        
        AF.request("https://api.vk.com" + "/method/\(object).get", method: .get, parameters: parameters).responseJSON { responce in
            print(object)
            print(responce.value!)
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
