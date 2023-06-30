//
//  HabitApp.swift
//  Habit
//
//  Created by Lucas Constante on 03/04/23.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
