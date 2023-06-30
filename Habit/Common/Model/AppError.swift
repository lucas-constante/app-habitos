//
//  AppError.swift
//  Habit
//
//  Created by Lucas Constante on 04/05/23.
//

import Foundation

enum AppError: Error {
case response(message: String)
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
