//
//  TasksViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 1.06.2021.
//

import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    let viewModel = TasksViewModel()
    
    var taskSize = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "tasks_title".localized
        taskTableView.delegate = viewModel
        taskTableView.dataSource = viewModel
        
        taskTableView.register(TaskTableViewCell.nib(), forCellReuseIdentifier: TaskTableViewCell.identifier)
        showSpinner()
        taskTableView.isHidden = true
        
        viewModel.getTasksDataFromProfile()
        viewModel.didTasksGetFetched = {
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
                self.taskTableView.isHidden = false
                self.removeSpinner()
            }
        }
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
