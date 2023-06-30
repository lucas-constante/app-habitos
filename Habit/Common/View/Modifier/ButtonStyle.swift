//
//  ButtonStyle.swift
//  Habit
//
//  Created by Lucas Constante on 11/05/23.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(4.0)
    }
    
}
