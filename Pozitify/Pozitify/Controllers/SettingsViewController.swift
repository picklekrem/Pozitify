//
//  SettingsViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 12.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    let settingItems : [SettingItems] =
    [SettingItems(name: "change_theme".localized, image: UIImage(systemName: "paintpalette")!, info: .changeTheme),
     SettingItems(name: "privacy_notice".localized, image: UIImage(systemName: "doc.text")!, info: .privacyPolicy),
     SettingItems(name: "user_agreement".localized, image: UIImage(systemName: "doc.viewfinder")!, info: .userAgreement),
     SettingItems(name: "log_out".localized, image: UIImage(systemName: "rectangle.portrait.and.arrow.right")!, info: .logOut)
    ]
    
    @IBOutlet weak var settingsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "settings_title".localized
        settingsTableView.register(SettingsTableViewCell.nib(), forCellReuseIdentifier: SettingsTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    func itemSelected(task : SettingsItemsTasks) {
        switch task {
        case .changeTheme:
            print("change theme clicked")
        case .privacyPolicy:
            print("privacy clicked")
        case .userAgreement:
            print("user agreement clicked")
        case .logOut:
            print("logout clicked")
        }
    }
}
extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        settingCell.loadData(data: settingItems[indexPath.row])
        return settingCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemSelected(task: settingItems[indexPath.row].info)
    }
    
}
