//
//  TasksViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 1.06.2021.
//

import UIKit
import Firebase

class TasksViewController: UIViewController {
    
    let firestoreDatabase = Firestore.firestore()
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ekrem")
        print("ekrem")
        print("ekrem")
        taskTableView.separatorStyle = .none
        taskTableView.register(TaskTableViewCell.nib(), forCellReuseIdentifier: TaskTableViewCell.identifier)
        getData()
    }
    
    func getData() {
        
        firestoreDatabase.collection("Tasks").getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) ==> \(document.data())")
                }
            }
        }
    }
    
}

extension TasksViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = taskTableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        taskCell.taskTitleLabel.text = "asdadasdasdadsaaaaTEXTadadaaTEXTadadaaThasfhashads"
        taskCell.taskTextLabel.text = "TEXTadadadaaTEXTadadaaTEXTadXTadadaaTaTEXTadadaaT"
        
        return taskCell
    }
    
    
}
