//
//  Logger.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 23.01.2020.
//  Copyright © 2020 Aleksandr Fetisov. All rights reserved.
//

import Foundation

// MARK: - Receiver

final class Logger {
    
    func writeMessageToLog(_ message: String) {
        /// Здесь должна быть реализация записи сообщения в лог.
        /// Для простоты примера паттерна не вдаемся в эту реализацию,
        /// а просто печатаем текст в консоль.
        print(message)
    }
}
