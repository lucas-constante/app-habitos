//
//  HabitUIState.swift
//  Habit
//
//  Created by Lucas Constante on 10/05/23.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
