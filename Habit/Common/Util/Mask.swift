//
//  Mask.swift
//  Habit
//
//  Created by Lucas Constante on 23/06/23.
//

import Foundation

class Mask {
    
    static var isUpdating = false
    static var oldString = ""
    
    private static func repleaceChars(full: String) -> String {
        full.replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: "*", with: "")
            .replacingOccurrences(of: " ", with: "")
    }
    
    static func mask(mask: String, value: String, text: inout String) {
        let str = Mask.repleaceChars(full: value)
        var cpfWithMask = ""
        
        var _mask = mask
        if (_mask == "(##) ####-####") {
            if (value.count >= 14 && value.characterAtIndex(index: 5) == "9") {
                _mask = "(##) #####-####"
            }
        }
        
        if (str <= oldString) { // estou deletando
            isUpdating = true
            if (_mask == "(##) #####-####" && value.count == 14) {
                _mask = "(##) ####-####"
            }
        }
        
        if (isUpdating || value.count == mask.count) {
            oldString = str
            isUpdating = false
            return
        }
        
        var i = 0
        for char in _mask {
            if (char != "#" && str.count > oldString.count) {
                cpfWithMask = cpfWithMask + String(char)
                continue
            }
            
            let unamed = str.characterAtIndex(index: i)
            guard let char = unamed else { break }
            
            cpfWithMask = cpfWithMask + String(char)
            
            i = i + 1
            
        }
        
        isUpdating = true
        
        if (cpfWithMask == "(0") {
            text = ""
            return
        }
        
        text = cpfWithMask
        print(text)
    }
    
}
