//
//  HistoryScreenRouter.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation


@MainActor
protocol HistoryScreenRouter {}

@MainActor
final class HistoryScreenRouterImpl: ObservableObject { }
extension HistoryScreenRouterImpl: HistoryScreenRouter {}
