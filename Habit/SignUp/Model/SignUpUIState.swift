//
//  SignUpUIState.swift
//  Habit
//
//  Created by Lucas Constante on 12/04/23.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
