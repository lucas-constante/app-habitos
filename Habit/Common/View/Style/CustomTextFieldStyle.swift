//
//  CustomTextFieldStyle.swift
//  Habit
//
//  Created by Lucas Constante on 13/04/23.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color(red: 0.545, green: 0.783, blue: 0.252),
                        lineWidth: 0.8)
        )
    }
    
}
