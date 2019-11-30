//
//  PhotoService.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 24.10.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit
import Alamofire

class PhotoService {
    
    private var memoryCache = [String: UIImage]()
    private let cacheLifeTime: TimeInterval = 60*60*24*7
    private static let pathName: String = {
        
        let pathName = "images"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    private func getFilePath(urlString: String) -> String? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let hashName = urlString.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(urlString: String, image: UIImage) {
        guard let fileName = getFilePath(urlString: urlString) else { return }
        let data = image.jpegData(compressionQuality: 1)
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(urlString: String) -> UIImage? {
        guard
            let fileName = getFilePath(urlString: urlString),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        memoryCache[urlString] = image
        return image
    }
    
    private func loadPhoto(urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        Alamofire.request(urlString).responseData() { [weak self] response in
            guard
                let self = self,
                let data = response.data,
                let image = UIImage(data: data) else {
                    completion(nil)
                    return
            }
            self.memoryCache[urlString] = image
            self.saveImageToCache(urlString: urlString, image: image)
            completion(image)
        }
    }
    
    func setPhoto(urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        if let image = memoryCache[urlString] {
            completion(image)
        } else if let image = getImageFromCache(urlString: urlString) {
            completion(image)
        } else {
            loadPhoto(urlString: urlString, completion: completion)
        }
    }
}


