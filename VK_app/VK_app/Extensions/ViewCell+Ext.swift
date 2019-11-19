//
//  UITableViewCell+Ext.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 02.11.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

protocol Reusable {}

extension UITableViewCell: Reusable {}

extension Reusable where Self: UITableViewCell {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: Reusable {}

extension Reusable where Self: UICollectionViewCell {
    static var reuseID: String {
        return String(describing: self)
    }
}
