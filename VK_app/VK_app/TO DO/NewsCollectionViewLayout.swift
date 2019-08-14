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
    var columnsCount = 2
    var cellHeight: CGFloat = 128
    private var totalCellsHeight: CGFloat = 0
  
    override func prepare() {
        super.prepare()
        
        self.cacheAttributes = [:]
        guard let collectionView = self.collectionView else { return }
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return }
        
        let bigCellWidth = collectionView.frame.width
        let smallCellWidth = collectionView.frame.width / CGFloat(self.columnsCount)
        
        var lastY: CGFloat = 0
        var lastX: CGFloat = 0
    
        for index in 0..<itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
            let isBigCell = (index + 1) % (self.columnsCount + 1) == 0
    
            if isBigCell {
                attributes.frame = CGRect(x: 0, y: lastY, width: bigCellWidth, height: self.cellHeight)
                lastY += self.cellHeight
            } else {
                attributes.frame = CGRect(x: lastX, y: lastY, width: smallCellWidth, height: self.cellHeight)
            
                let isLastColumn = (index + 2) % (self.columnsCount + 1) == 0 || index == itemsCount - 1
            
                if isLastColumn {
                    lastX = 0
                    lastY += self.cellHeight
                } else {
                    lastX += smallCellWidth
                }
            }
            cacheAttributes[indexPath] = attributes
        }
        self.totalCellsHeight = lastY
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
        return CGSize(width: self.collectionView?.frame.width ?? 0,
                      height: self.totalCellsHeight)
    }
}