//
//  TaskTableViewCell.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 1.06.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskTextLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    static let identifier = "TaskTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "TaskTableViewCell", bundle: nil)
    }
    
    var detailData : TaskContainerList?
    var isCompletedCompletion : (Bool) -> () = {result in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.shadowColor = UIColor.gray.cgColor
        backView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        backView.layer.shadowOpacity = 1.0
        backView.layer.masksToBounds = false
        backView.layer.cornerRadius = 4.0

        checkButton.isUserInteractionEnabled = false
    }
    
    func loadData(data : TaskContainerList) {
        detailData = data
        taskTitleLabel.text = data.taskTitle
        taskTextLabel.text = data.taskInfo
        DispatchQueue.main.async {
            if data.isComplete {
                self.setSelected(true, animated: true)
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            checkButton.setImage(UIImage(named: "SelectedButton"), for: .normal)
            self.isCompletedCompletion(true)
        } else {
            checkButton.setImage(UIImage(named: "UnselectedButton"), for: .normal)
            self.isCompletedCompletion(false)
        }
    }
    
}
