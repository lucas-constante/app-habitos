//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Lucas Constante on 12/04/23.
//

import SwiftUI

enum SignUpViewRouter {
    
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
   
    
}
