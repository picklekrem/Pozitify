//
//  Enums.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 12.11.2022.
//

import Foundation

enum TasksValue : String, CaseIterable {
    case ideaCount = "ideaCount"
    case userName = "userName"
}

enum TasksListName : String {
    case tasks = "Tasks"
    case currentTasks = "CurrentTasks"
    case waitingTasks = "WaitingTasks"

    static let allValues = [tasks, currentTasks, waitingTasks]
    
}

enum SettingsItemsTasks {
    case changeTheme
    case privacyPolicy
    case userAgreement
    case logOut
}
