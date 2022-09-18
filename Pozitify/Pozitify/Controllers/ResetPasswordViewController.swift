//
//  ResetPasswordViewController.swift
//  Pozitify
//
//  Created by Onur Başdaş on 6.08.2021.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet var resetCodeText: UITextField!
    @IBOutlet var newPasswordText: UITextField!
    @IBOutlet var confirmPasswordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conf()
    }
    
    func conf() {
        newPasswordText.addBottomBorder()
        confirmPasswordText.addBottomBorder()
    }
    
    @IBAction func changePasswordClicked(_ sender: Any) {
        if newPasswordText.text == confirmPasswordText.text && (newPasswordText.text != "") && (confirmPasswordText.text != "") {
            loadScreen(name: "Auth", identifier: "succesful")
        } else {
            makeAlert(titleInput: "Oh No", messageInput: "Please match password")
        }
        
    }
}
