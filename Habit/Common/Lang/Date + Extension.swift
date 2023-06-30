//
//  Date + Extension.swift
//  Habit
//
//  Created by Lucas Constante on 15/05/23.
//

import Foundation

extension Date {
    
    func toString(destPattern dest: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dest
        
        return formatter.string(from: self)
    }
    
}
