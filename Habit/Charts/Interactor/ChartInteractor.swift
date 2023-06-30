//
//  ChartInteractor.swift
//  Habit
//
//  Created by Lucas Constante on 09/06/23.
//

import Foundation
import Combine

class ChartInteractor {
    
    private let remote: ChartRemoteDataSource = .shared
    
}

extension ChartInteractor {
    
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppError> {
        return remote.fetchHabitValues(habitId: habitId)
    }
    
}
