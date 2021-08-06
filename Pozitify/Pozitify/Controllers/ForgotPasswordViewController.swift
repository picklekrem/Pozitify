//
//  ForgotPasswordViewController.swift
//  Pozitify
//
//  Created by Onur Başdaş on 2.08.2021.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet var forgotEmailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendRequestClicked(_ sender: Any) {
        if forgotEmailText.text == "" {
            makeAlert(titleInput: "Oh No", messageInput: "Please enter your e-mail")
        }
        performSegue(withIdentifier: "toResetPassword", sender: nil)
    }
}
