//
//  ProfileViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 1.06.2021.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePictureUpload()
    }
    
    func profilePictureUpload() {
        let profilePic = UserDefaults.standard.object(forKey: "profilePicture") as? NSData
        if profilePic == nil {
            profileImageView.image = UIImage(named: "profilePlaceHolder")
        }else {
            profileImageView.image = UIImage(data: profilePic! as Data)
        }
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.loadScreen(name: "Auth", identifier: "loginVC")
        }catch{
            print("error")
        }
    }
}
