//
//  ErrorResponse.swift
//  Habit
//
//  Created by Lucas Constante on 02/05/23.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
