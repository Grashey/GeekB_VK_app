//
//  LoggerInvoker.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 23.01.2020.
//  Copyright © 2020 Aleksandr Fetisov. All rights reserved.
//

import Foundation

// MARK: - Invoker

internal final class LoggerInvoker {
    
    // MARK: Singleton
    
    internal static let shared = LoggerInvoker()
    
    // MARK: Private properties
    
    private let logger = Logger()
    
    private let batchSize = 5
    
    private var commands: [LogAction] = []
    
    // MARK: Internal
    
    internal func addLogCommand(_ command: LogAction) {
        self.commands.append(command)
        self.executeCommandsIfNeeded()
    }
    
    // MARK: Private
    
    private func executeCommandsIfNeeded() {
        guard self.commands.count >= batchSize else {
            return
        }
        self.commands.forEach { self.logger.writeMessageToLog($0.logMessage) }
        self.commands = []
    }
}
