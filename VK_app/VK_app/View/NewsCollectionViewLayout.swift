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
        
<<<<<<< HEAD
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
=======
        let cellWidth = collectionView.frame.width
        let cellHeight = collectionView.frame.height
        let aspectRatio = cellHeight / cellWidth
        
        var lastY: CGFloat = 0
        var lastX: CGFloat = 0
        let indent: CGFloat = 3
>>>>>>> remaster
    
        switch itemsCount {
        case 1:
            let indexPath = IndexPath(item: 0, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
<<<<<<< HEAD
            attributes.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
=======
            attributes.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight)
>>>>>>> remaster
            cacheAttributes[indexPath] = attributes
            
        case 2:
            for index in 0..<itemsCount {
                let indexPath = IndexPath(item: index, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                if index == 0 {
<<<<<<< HEAD
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
=======
                    lastX = 0
                } else {
                    lastX = cellWidth / 2
                }
                attributes.frame = CGRect(x: lastX, y: lastY, width: (cellWidth / 2) - indent, height: cellHeight)
>>>>>>> remaster
                cacheAttributes[indexPath] = attributes
            }
            
        case 3:
            for index in 0..<itemsCount {
                let indexPath = IndexPath(item: index, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
<<<<<<< HEAD
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
=======
                var height = CGFloat()
                var width = CGFloat()
                if index == 0 {
                    lastX = 0
                    lastY = 0
                    height = cellHeight
                    width = cellWidth / 3 * 2 - indent
                } else if index == 1 {
                    lastX = cellWidth / 3 * 2 //+ indent
                    lastY = 0
                    height = cellHeight / 2 - indent
                    width = cellWidth / 3 - indent
                } else if index == 2 {
                    lastX = cellWidth / 3 * 2 //+ indent
                    lastY = cellHeight / 2 //+ indent
                    height = cellHeight / 2 - indent
                    width = cellWidth / 3 - indent
                }
                attributes.frame = CGRect(x: lastX, y: lastY, width: width, height: height)
>>>>>>> remaster
                cacheAttributes[indexPath] = attributes
           }
            
        case 4:
            for index in 0..<itemsCount {
                let indexPath = IndexPath(item: index, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
<<<<<<< HEAD
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
=======
                var height = CGFloat()
                var width = CGFloat()
                if index == 0 {
                    lastX = 0
                    lastY = 0
                    height = cellHeight / 2 - indent
                    width = cellWidth / 2 - indent
                } else if index == 1 {
                    lastX = cellWidth / 2 //+ indent
                    lastY = 0
                    height = cellHeight / 2 - indent
                    width = cellWidth / 2 - indent
                } else if index == 2 {
                    lastX = 0
                    lastY = cellHeight / 2 //+ indent
                    height = cellHeight / 2 - indent
                    width = cellWidth / 2 - indent
                } else if index == 3 {
                    lastX = cellWidth / 2 //+ indent
                    lastY = cellHeight / 2 //+ indent
                    height = cellHeight / 2 - indent
                    width = cellWidth / 2 - indent
                }
                attributes.frame = CGRect(x: lastX, y: lastY, width: width, height: height)
>>>>>>> remaster
                cacheAttributes[indexPath] = attributes
            }
            
        default:
            for index in 0..<itemsCount {
                let indexPath = IndexPath(item: index, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
<<<<<<< HEAD
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
=======
                var height = CGFloat()
                var width = CGFloat()
                if index == 0 {
                    lastX = 0
                    lastY = 0
                    height = cellHeight / 3 * 2 - indent
                    width = cellWidth / 2 - indent
                } else if index == 1 {
                    lastX = cellWidth / 2 //+ indent
                    lastY = 0
                    height = cellHeight / 3 * 2 - indent
                    width = cellWidth / 2 - indent
                } else if index == 2 {
                    lastX = 0
                    lastY = cellHeight / 3 * 2 //+ indent
                    height = cellHeight / 3 - indent
                    width = cellWidth / 3 - indent
                } else if index == 3 {
                    lastX = cellWidth / 3 //+ indent
                    lastY = cellHeight / 3 * 2 //+ indent
                    height = cellHeight / 3 - indent
                    width = cellWidth / 3 - indent
                } else if index == 4 {
                    lastX = cellWidth / 3 * 2 //+ indent
                    lastY = cellHeight / 3 * 2 //+ indent
                    height = cellHeight / 3 - indent
                    width = cellWidth / 3 - indent
                }
                attributes.frame = CGRect(x: lastX, y: lastY, width: width, height: height)
>>>>>>> remaster
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
