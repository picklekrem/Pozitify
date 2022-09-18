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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var animationView: UIView!
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePictureUpload()
        viewModel.getUserInfo()
        viewModel.didGetUserInfoFetched = { response in
            DispatchQueue.main.async {
                self.nameLabel.text = response.userName
                self.infoLabel.text = response.userEmail
            }
        }
    }
    
    func profilePictureUpload() {
        profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImageView.addGestureRecognizer(gestureRecognizer)
        let profilePic = UserDefaults.standard.object(forKey: "profilePicture") as? NSData
        if profilePic == nil {
            profileImageView.image = UIImage(named: "profilePlaceHolder")
        }else {
            profileImageView.image = UIImage(data: profilePic! as Data)
        }
        profileImageView.roundedImage()
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



