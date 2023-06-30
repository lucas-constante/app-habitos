//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by Lucas Constante on 15/05/23.
//

import Foundation


enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
