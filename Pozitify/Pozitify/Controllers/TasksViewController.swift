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
    
    var taskContainerList : [TaskContainerList] = []
    let decoder = JSONDecoder()
    var taskSize = 3
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskTableView.separatorStyle = .none
        taskTableView.register(TaskTableViewCell.nib(), forCellReuseIdentifier: TaskTableViewCell.identifier)
        showSpinner()
        taskTableView.isHidden = true
        getData()
    }
    
    func getData() {
        
        firestoreDatabase.collection("Tasks").getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) ==> \(document.data())")
                    
//                    self.defaults.set(document.data(), forKey: "myKey")
//                    let deneme = [self.defaults.dictionary(forKey: "myKey")]
//                    print(deneme)
                    do{
                        let jsonData = try? JSONSerialization.data(withJSONObject:document.data())
                        let taskModel = try self.decoder.decode(TaskContainerList.self, from: jsonData!)
                        self.taskContainerList.append(taskModel)
//                        a = yapılacaklar     &&    b = yapılmışlar
//                        biz her zaman A dan çekicez verileri
//                        A da yapıldığında B ye kaydedicez, sonra A dan silicez.
                    }
                    catch let err
                    {
                        print(err)
                    }
                    self.taskContainerList.shuffle()
                    self.taskTableView.reloadData()
                    self.taskTableView.isHidden = false
                    self.removeSpinner()
                }
                
            }
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
