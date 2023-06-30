//
//  HabitCreateInteractor.swift
//  Habit
//
//  Created by Lucas Constante on 15/06/23.
//

import Foundation
import Combine

class HabitCreateInteractor {
    
    private let remote: HabitCreateRemoteDataSource = .shared
    
}

extension HabitCreateInteractor {
    
    func save(habitCreateRequest request: HabitCreateRequest) -> Future<Void, AppError> {
        return remote.save(request: request)
    }
}
