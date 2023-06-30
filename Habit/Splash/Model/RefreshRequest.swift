//
//  RefreshRequest.swift
//  Habit
//
//  Created by Lucas Constante on 09/05/23.
//

import Foundation

struct RefreshRequest: Encodable {
    
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
    
}
