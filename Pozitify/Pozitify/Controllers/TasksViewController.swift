//
//  TasksViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 1.06.2021.
//

import UIKit

class TasksViewController: UIViewController {
    @IBOutlet weak var taskTableView: UITableView!
    
    var taskContainerList : [TaskContainerList] = []
    var taskSize = 3
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.register(TaskTableViewCell.nib(), forCellReuseIdentifier: TaskTableViewCell.identifier)
        showSpinner()
        taskTableView.isHidden = true
        getData()
    }
    func getData(){
        WebService().getTaskData { response in
            self.taskContainerList.append(response!)
            self.taskTableView.reloadData()
            self.taskTableView.isHidden = false
            self.removeSpinner()
        }
    }
}

extension TasksViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = taskTableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        if taskContainerList.count != 0 && indexPath.row <= taskSize {
            taskCell.taskTitleLabel.text = taskContainerList[indexPath.row].Title
            taskCell.taskTextLabel.text = taskContainerList[indexPath.row].Task
        }
        return taskCell
    }
    
    
}
