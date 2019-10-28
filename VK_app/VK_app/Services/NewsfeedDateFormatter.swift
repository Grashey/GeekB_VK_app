//
//  NewsfeedDateFormatter.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 28.10.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import Foundation

class NewsfeedDateFormatter {

    let currentDateTime = Date().timeIntervalSince1970
    let calendar = Calendar.current
    let today = Date()
    var postDate = Date()
    var postDateAgo = Date()
    var monthString = String()
    
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
    
    func getcurrentDate(date: Int) -> String {
        
        let inter = Int(currentDateTime) - date
        postDateAgo = Date(timeIntervalSinceReferenceDate: TimeInterval(inter))
        postDate = Date(timeIntervalSince1970: TimeInterval(date))
        
        return postStringDate(inter)
    }
        
    func postStringDate(_ interval: Int) -> String {
        var text = String()
        let oneHour = 60*60
        
        let month = calendar.component(.month, from: postDate)
        let day = calendar.component(.day, from: postDate)
        let hour = calendar.component(.hour, from: postDate)
        let minute = calendar.component(.minute, from: postDate)
        
        let minutesAgo = calendar.component(.minute, from: postDateAgo)
        let secondsAgo = calendar.component(.second, from: postDateAgo)
        let currentDay = calendar.component(.day, from: today)
        
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
        
        if interval < 60 {
            text = "\(secondsAgo) секунд назад"
        } else if interval < oneHour {
            text = "\(minutesAgo) минут назад"
        } else if interval < oneHour * 2 {
            text = "час назад"
        } else if interval < oneHour * 3 {
            text = "два часа назад"
        } else if interval < oneHour * 4 {
            text = "три часа назад"
        } else if day == currentDay {
            text = "сегодня в \(hour):\(minute)"
        } else {
            text = "\(day) \(monthString) в \(hour):\(minute)"
        }
        return text
    }
}
