//
//  NewsCollectionViewLayout.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 12/08/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsCollectionViewLayout: UICollectionViewLayout {
    
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
  
    override func prepare() {
        super.prepare()
        
        self.cacheAttributes = [:]
        guard let collectionView = self.collectionView else { return }
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return }
        
        let viewWidth = collectionView.frame.width
        let viewHeight = collectionView.frame.height
        //let aspectRatio = cellHeight / cellWidth
        
        var originY = CGFloat()
        var originX = CGFloat()
        var height = CGFloat()
        var width = CGFloat()
        let indent: CGFloat = 4
        let twoItems: CGFloat = 2
        let threeItems: CGFloat = 3
    
        switch itemsCount {
        case 1:
            let indexPath = IndexPath(item: 0, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
            cacheAttributes[indexPath] = attributes
            
        case 2:
            for index in 0..<itemsCount {
                let indexPath = IndexPath(item: index, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                if index == 0 {
                    originX = 0
                    originY = 0
                    height = viewHeight
                    width = (viewWidth - indent) / twoItems
                } else {
                    originX = (viewWidth - indent) / twoItems + indent
                    originY = 0
                    height = viewHeight
                    width = (viewWidth - indent) / twoItems
                }
                attributes.frame = CGRect(x: originX, y: originY, width: width, height: height)
                cacheAttributes[indexPath] = attributes
            }
            
        case 3:
            for index in 0..<itemsCount {
                let indexPath = IndexPath(item: index, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                if index == 0 {
                    originX = 0
                    originY = 0
                    height = viewHeight
                    width = (viewWidth - indent) / threeItems * 2
                } else if index == 1 {
                    originX = (viewWidth - indent) / threeItems * 2 + indent
                    originY = 0
                    height = (viewHeight - indent) / twoItems
                    width = (viewWidth - indent) / threeItems
                } else if index == 2 {
                    originX = (viewWidth - indent) / threeItems * 2 + indent
                    originY = (viewHeight - indent) / twoItems + indent
                    height = (viewHeight - indent) / twoItems
                    width = (viewWidth - indent) / threeItems
                }
                attributes.frame = CGRect(x: originX, y: originY, width: width, height: height)
                cacheAttributes[indexPath] = attributes
           }
            
        case 4:
            for index in 0..<itemsCount {
                let indexPath = IndexPath(item: index, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                if index == 0 {
                    originX = 0
                    originY = 0
                    height = (viewHeight - indent) / twoItems
                    width = (viewWidth - indent) / twoItems
                } else if index == 1 {
                    originX = (viewWidth - indent) / twoItems + indent
                    originY = 0
                    height = (viewHeight - indent) / twoItems
                    width = (viewWidth - indent) / twoItems
                } else if index == 2 {
                    originX = 0
                    originY = (viewHeight - indent) / twoItems + indent
                    height = (viewHeight - indent) / twoItems
                    width = (viewWidth - indent) / twoItems
                } else if index == 3 {
                    originX = (viewWidth - indent) / twoItems + indent
                    originY = (viewHeight - indent) / twoItems + indent
                    height = (viewHeight - indent) / twoItems
                    width = (viewWidth - indent) / twoItems
                }
                attributes.frame = CGRect(x: originX, y: originY, width: width, height: height)
                cacheAttributes[indexPath] = attributes
            }
            
        default:
            for index in 0..<itemsCount {
                let indexPath = IndexPath(item: index, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                if index == 0 {
                    originX = 0
                    originY = 0
                    height = (viewHeight - indent) / threeItems * 2
                    width = (viewWidth - indent) / twoItems
                } else if index == 1 {
                    originX = (viewWidth - indent) / twoItems + indent
                    originY = 0
                    height = (viewHeight - indent) / threeItems * 2
                    width = (viewWidth - indent) / twoItems
                } else if index == 2 {
                    originX = 0
                    originY = (viewHeight - indent) / threeItems * 2 + indent
                    height = (viewHeight - indent) / threeItems
                    width = (viewWidth - indent * 2) / threeItems
                } else if index == 3 {
                    originX = (viewWidth - indent * 2) / threeItems + indent
                    originY = (viewHeight - indent) / threeItems * 2 + indent
                    height = (viewHeight - indent) / threeItems
                    width = (viewWidth - indent * 2) / threeItems
                } else if index == 4 {
                    originX = (viewWidth - indent * 2) / threeItems * 2 + indent * 2
                    originY = (viewHeight - indent) / threeItems * 2 + indent
                    height = (viewHeight - indent) / threeItems
                    width = (viewWidth - indent * 2) / threeItems
                }
                attributes.frame = CGRect(x: originX, y: originY, width: width, height: height)
                cacheAttributes[indexPath] = attributes
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter { attributes in
            return rect.intersects(attributes.frame)
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.frame.width ?? 0,
                      height: collectionView?.frame.height ?? 0)
    }
}
