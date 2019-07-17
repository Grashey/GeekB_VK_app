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
    @IBOutlet weak var photoFullScreenView: UIImageView!
    var photoFullScreen = UIImage()
    
    override func viewDidLoad() {
     photoFullScreenView.image = photoFullScreen
    }
    
}
