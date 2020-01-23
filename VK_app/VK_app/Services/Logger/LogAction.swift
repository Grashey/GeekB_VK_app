//
//  LogAction.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 23.01.2020.
//  Copyright © 2020 Aleksandr Fetisov. All rights reserved.
//

import Foundation

// MARK: - Command

final class LogAction {
    
    let action: String
    let date: Date
       
    init(action: String, date: Date) {
        self.action = action
        self.date = date
    }
    
    static public func log(date: Date, description: String) {
        let command = LogAction(action: description, date: Date())
        LoggerInvoker.shared.addLogCommand(command)
    }
    
    var logMessage: String {
        return "\(action) was called at \(date)"
    }
}
