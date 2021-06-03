//
//  ProfileViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 1.06.2021.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
