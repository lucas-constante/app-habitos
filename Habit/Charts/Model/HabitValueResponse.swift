//
//  HabitValueResponse.swift
//  Habit
//
//  Created by Lucas Constante on 09/06/23.
//

import Foundation

struct HabitValueResponse: Decodable {
    
    let id: Int
    let value: Int
    let habitId: Int
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case habitId = "habit_id"
        case createdDate = "created_date"
    }
    
}
