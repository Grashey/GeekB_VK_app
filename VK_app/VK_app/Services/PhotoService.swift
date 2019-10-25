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
    
    private func getFilePath(url: String) -> String? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url) else { return }
        let data = image.pngData()
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        images[url] = image
        return image
    }
    
    private var images = [String: UIImage]()
    
    private func loadPhoto(atIndexPath indexPath: IndexPath, byUrl url: String) {
        
        Alamofire.request(url).responseData(queue: .global()) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data) else { return }
            
            self?.images[url] = image
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexPath: indexPath)
            }
        }
    }
    
    func photo(atIndexPath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexPath: indexPath, byUrl: url)
        }
        return image
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexPath indexPath: IndexPath)
}

extension PhotoService {
    
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        } 
    }
}
