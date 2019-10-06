//
//  NewsHeaderCell.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 06/09/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class NewsHeaderCell: UITableViewCell {

    @IBOutlet weak var groupAvatar: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    public func configure(with group: NewsGroup, date: Int) {
        groupLabel.text = group.groupName
        
        let imageUrl = URL(string: group.groupAvatar)
        groupAvatar.kf.setImage(with: imageUrl)
        
        let currentDateTime = Date().timeIntervalSince1970
        let inter = Int(currentDateTime) - date
        let postDateAgo = Date(timeIntervalSinceReferenceDate: TimeInterval(inter))
        let postDate = Date(timeIntervalSince1970: TimeInterval(date))
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: postDate)
        let day = calendar.component(.day, from: postDate)
        let hour = calendar.component(.hour, from: postDate)
        let minute = calendar.component(.minute, from: postDate)
        
        let minutesAgo = calendar.component(.minute, from: postDateAgo)
        let secondsAgo = calendar.component(.second, from: postDateAgo)
        
        let today = Date()
        let currentDay = calendar.component(.day, from: today)
        
        enum monthsState: String {
            case one = "января"
            case two = "февраля"
            case three = "марта"
            case four = "апреля"
            case five = "мая"
            case six = "июня"
            case seven = "июля"
            case eight = "августа"
            case nine = "сентября"
            case ten = "октября"
            case eleven = "ноября"
            case twelve = "декабря"
        }
        var monthString = String()
        
        switch month {
        case 1:
            monthString = monthsState.one.rawValue
        case 2:
            monthString = monthsState.two.rawValue
        case 3:
            monthString = monthsState.three.rawValue
        case 4:
            monthString = monthsState.four.rawValue
        case 5:
            monthString = monthsState.five.rawValue
        case 6:
            monthString = monthsState.six.rawValue
        case 7:
            monthString = monthsState.seven.rawValue
        case 8:
            monthString = monthsState.eight.rawValue
        case 9:
            monthString = monthsState.nine.rawValue
        case 10:
            monthString = monthsState.ten.rawValue
        case 11:
            monthString = monthsState.eleven.rawValue
        case 12:
            monthString = monthsState.twelve.rawValue
        default:
            monthString = String(month)
        }
            
        func postStringDate(_ interval: Int) -> String {
            var text = String()
            if interval < 60 {
                text = "\(secondsAgo) секунд назад"
            } else if interval < 3600 {
                text = "\(minutesAgo) минут назад"
            } else if interval < 7200 {
                text = "час назад"
            } else if interval < 10800 {
                text = "два часа назад"
            } else if interval < 14400 {
                text = "три часа назад"
            } else if day == currentDay {
                text = "сегодня в \(hour):\(minute)"
            } else {
                text = "\(day) \(monthString) в \(hour):\(minute)"
            }
            return text
        }
        timeLabel.text = postStringDate(inter)
    }
}
