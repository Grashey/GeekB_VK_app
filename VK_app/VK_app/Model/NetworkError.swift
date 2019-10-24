//
//  NetworkError.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 15.10.2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case JsonError(message: String)
}
extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .JsonError(let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
