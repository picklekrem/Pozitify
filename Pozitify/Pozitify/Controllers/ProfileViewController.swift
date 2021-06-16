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
        
        // Access Shared Defaults Object
//        let userDefaults = UserDefaults.standard
//        
//        // Create and Write Array of Strings
//        let array = ["One", "Two", "Three"]
//        userDefaults.set(array, forKey: "myKey")
//        
//        // Read/Get Array of Strings
//        var strings = [Array<Any>]()
//        strings = userDefaults.object(forKey: "myKey") as! [Array<Any>]
//        print(strings[0])
//        let name = UserDefaults.standard.object(forKey: "FullName") as! String
//        print(name)
        
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
            print("logout yapıldı.")
            self.loadScreen(name: "Auth", identifier: "loginVC")
            //self.performSegue(withIdentifier: "toAuthVC", sender: nil)
        }catch{
            print("error")
        }
    }
}
