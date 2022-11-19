//
//  SettingsTableViewCell.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 12.11.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "SettingsTableViewCell", bundle: nil)
    }

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.shadowColor = UIColor.gray.cgColor
        backView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        backView.layer.shadowOpacity = 1.0
        backView.layer.masksToBounds = false
        backView.layer.cornerRadius = 4.0
    }
    
    func loadData(data : SettingItems) {
        settingImage.image = data.image
        settingLabel.text = data.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
