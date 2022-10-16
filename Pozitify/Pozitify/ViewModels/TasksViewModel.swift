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
        webService.getTaskDataFromProfile { response in
            switch response {
            case .success(let tasks):
//                self.tasks = tasks
                guard let tasks = tasks else {return}
                if self.oneWeekCheck(tasks.first?.createdDate.stringToDate() ?? Date()) {
                    self.taskContainerList = tasks
                    self.didTasksGetFetched()
                } else {
                    self.getNewTasks(tasks: tasks)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func oneWeekCheck (_ createdDate : Date) -> Bool {
        let today = Date()
        let components = Calendar.current.dateComponents([.weekOfYear, .day], from: createdDate, to: today)
        if components.weekOfYear == 1 {
//            get newTasks
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
                firestoreDatabase.collection("Users").document(userOnline).collection("WaitingTasks").document(task.taskId).updateData(taskDic)
            }
        }
       
        #warning("current list'e waiting listten random 3 tane task çek")
        
        
        
        
    }
    
}

//Create an Enum file and make it general and spesific
enum TasksValue : String, CaseIterable {
    case ideaCount = "ideaCount"
    case userName = "userName"
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
        print(taskContainerList[indexPath.row].isComplete)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(taskContainerList[indexPath.row].isComplete)
    }

}
//                nicely done kardeşim thats work.
//                let userDictionary = [TasksValue.ideaCount.rawValue : 1, TasksValue.userName.rawValue : "ekrem"] as [String : Any]
//                self.firestoreDatabase.collection("Users").document(Auth.auth().currentUser!.email!).updateData(userDictionary)
                
