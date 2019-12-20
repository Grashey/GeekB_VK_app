//
//  LoadingDotView.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 29/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class LoadingDotView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        var path = UIBezierPath()
        path = UIBezierPath(ovalIn: CGRect(x: frame.height/4, y: frame.width/4, width: frame.width/3, height: frame.height/3))
        UIColor.vkWhite.setStroke()
        UIColor.vkWhite.setFill()
        path.lineWidth = 5
        path.stroke()
        path.fill()
    }
}
