//
//  TasksViewModel.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 4.07.2022.
//

import UIKit
import Firebase

class TasksViewModel: NSObject {
    let webService = WebService()
    let taskSize = 3
    var taskContainerList : [TaskContainerList] = []
    let firestoreDatabase = Firestore.firestore()
    let userOnline = Auth.auth().currentUser!.email!
    var didTasksGetFetched : () -> () = {}
    
    func getTasksDataFromProfile() {
        webService.getTaskDataFromProfile(listName: .currentTasks) { response in
            switch response {
            case .success(let tasks):
//                self.tasks = tasks
                guard let tasks = tasks else {return}
                if self.oneWeekCheck(tasks.first?.createdDate.stringToDate() ?? Date()) {
                    self.getNewTasks(tasks: tasks)
                } else {
                    self.taskContainerList = tasks
                    self.didTasksGetFetched()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func oneWeekCheck (_ createdDate : Date) -> Bool {
        let today = Date()
//        productionda değiştir from to datelerin yerini
        let components = Calendar.current.dateComponents([.weekOfYear], from: createdDate, to: today)
        if components.weekOfYear! >= 1 {
            return true
        } else {
            return false
        }
    }
    
    func getNewTasks(tasks : [TaskContainerList]) {
        tasks.forEach { task in
            firestoreDatabase.collection("Users").document(userOnline).collection("CurrentTasks").document(task.taskId).delete()
            if task.isComplete == true {
                let taskComplete = ["isComplete" : true] as [String : Any]
                firestoreDatabase.collection("Users").document(userOnline).collection("Tasks").document(task.taskId).updateData(taskComplete)
            } else {
                var taskDic = [:] as [String : Any]
                taskDic["taskInfo"] = task.taskInfo
                taskDic["taskId"] = task.taskId
                taskDic["taskTitle"] = task.taskTitle
                taskDic["isComplete"] = task.isComplete
                taskDic["createdDate"] = ""
                firestoreDatabase.collection("Users").document(userOnline).collection("WaitingTasks").document(task.taskId).setData(taskDic)
            }
        }
       generateNewTasks()
    }
    
    func generateNewTasks() {
        webService.getTaskDataFromProfile(listName: .waitingTasks) { response in
            switch response {
            case .success(let tasks):
                let randomTasks = tasks?.choose(3)
                var userDictionary = [:] as [String : Any]
                randomTasks?.forEach({ x in
                    userDictionary["taskInfo"] = x.taskInfo
                    userDictionary["taskId"] = x.taskId
                    userDictionary["taskTitle"] = x.taskTitle
                    userDictionary["isComplete"] = x.isComplete
                    userDictionary["createdDate"] = Date().dateToString()
                    
                    self.firestoreDatabase.collection("Users").document(self.userOnline).collection("CurrentTasks").document(x.taskId).setData(userDictionary)
                    self.firestoreDatabase.collection("Users").document(self.userOnline).collection("WaitingTasks").document(x.taskId).delete()
                    
                })
                self.getTasksDataFromProfile()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func didTasksComplete(isCheck : Bool, taskID : String) {
        let taskComplete = ["isComplete" : isCheck] as [String : Any]
        if isCheck {
            firestoreDatabase.collection("Users").document(userOnline).collection("CurrentTasks").document(taskID).updateData(taskComplete)
        } else {
            firestoreDatabase.collection("Users").document(userOnline).collection("CurrentTasks").document(taskID).updateData(taskComplete)
        }
    }
    
    
}

extension TasksViewModel : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskContainerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
            taskCell.loadData(data: taskContainerList[indexPath.row])
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskId = taskContainerList[indexPath.row].taskId
        didTasksComplete(isCheck: true, taskID: taskId)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let taskId = taskContainerList[indexPath.row].taskId
        didTasksComplete(isCheck: false, taskID: taskId)
    }
}
