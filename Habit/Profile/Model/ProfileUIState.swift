//
//  ProfileUIState.swift
//  Habit
//
//  Created by Lucas Constante on 29/05/23.
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
