//
//  ChartUIState.swift
//  Habit
//
//  Created by Lucas Constante on 09/06/23.
//

import Foundation

enum ChartUIState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
