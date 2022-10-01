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
    var didTasksGetFetched : () -> () = {}
    func getData() {
//        WebService().getTaskData { response in
//            guard let response = response else {
//                return
//            }
//            self.taskContainerList.append(response)
//            self.didTasksGetFetched()
//        }
        webService.shared.getTaskData { response in
            switch response {
            case .success(let tasks):
                guard let tasks = tasks else {return}
                self.taskContainerList.append(tasks)
                self.didTasksGetFetched()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        will fetched from profile
    }
}

extension TasksViewModel : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        if taskContainerList.count != 0 && indexPath.row <= taskSize {
            taskCell.loadData(data: taskContainerList[indexPath.row])
        }
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(taskContainerList[indexPath.row].isComplete)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(taskContainerList[indexPath.row].isComplete)
    }

}
