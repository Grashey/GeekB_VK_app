//
//  NewsViewController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 25/07/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    
    @IBOutlet var newsTable: UITableView!

    var groupAvatar = UIImage()
    var groupName = String()
    var likeCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //likeCountView.text = String(likeCount)
        
        //let likeGR = UITapGestureRecognizer(target: self, action: #selector(heartStateChanged))
        //likeGR.numberOfTapsRequired = 2
        //likeImageView.addGestureRecognizer(likeGR)

    }

    // MARK: - Tableview methods
    override func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        
        cell.groupAvatar.image = groupAvatar
        cell.groupLabel.text = groupName

        return cell
    }
    
   /* @objc private func heartStateChanged(){
        likeImageView.isHeartFilled.toggle()
        if likeCountView.text == String(likeCount){
            likeCountView.text = String(likeCount + 1)
        } else {
            likeCountView.text = String(likeCount)
        }
    }*/

}
