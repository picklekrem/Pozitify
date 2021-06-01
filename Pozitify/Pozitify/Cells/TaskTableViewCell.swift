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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.shadowColor = UIColor.gray.cgColor
        backView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        backView.layer.shadowOpacity = 1.0
        backView.layer.masksToBounds = false
        backView.layer.cornerRadius = 4.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func checkButtonClicked(_ sender: Any) {
    }
}
