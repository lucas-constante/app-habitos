//
//  HabitViewRouter.swift
//  Habit
//
//  Created by Lucas Constante on 13/06/23.
//

import Foundation
import Combine
import SwiftUI

enum HabitViewRouter {
    
    static func makeHabitCreateView(habitPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HabitCreateViewModel(interactor: HabitCreateInteractor())
        viewModel.habitPublisher = habitPublisher
        return HabitCreateView(viewModel: viewModel)
    }
    
}
