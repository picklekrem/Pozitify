//
//  TaskList.swift
//  Pozitify
//
//  Created by Onur Başdaş on 2.08.2021.
//

import Foundation


struct TaskContainerList: Codable {
    let taskTitle : String
    let taskInfo : String
    let taskId : String
    var isComplete : Bool
    
//    init(taskTitle : String, taskInfo : String, taskId : String, isComplete : Bool) {
//        self.taskTitle = taskTitle
//        self.taskInfo = taskInfo
//        self.taskId = taskId
//        self.isComplete = isComplete
//    }
}

