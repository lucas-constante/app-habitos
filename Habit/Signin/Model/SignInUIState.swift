//
//  SignInUIState.swift
//  Habit
//
//  Created by Lucas Constante on 11/04/23.
//

import Foundation

enum SignInUIState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
