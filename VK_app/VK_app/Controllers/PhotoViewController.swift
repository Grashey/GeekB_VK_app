//
//  PhotoViewController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 16/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

   // @IBOutlet var photoScrollView: UIScrollView!
    @IBOutlet weak var photoFullSizeView: UIImageView!
    var photoFullSize = UIImage()
    
    override func viewDidLoad() {
     photoFullSizeView.image = photoFullSize
    }
    
}
