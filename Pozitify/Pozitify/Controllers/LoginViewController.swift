//
//  LoginViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 3.06.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let firestoredatabase = Firestore.firestore()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
         
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authData, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Try again")
                }
                else {
                    //perform segue
                    print("login tamamlandı")
                    self.loadScreen(name: "Main", identifier: "tabBar")
                }
            }
            
        }
        else{
            self.makeAlert(titleInput: "Error!", messageInput: "Kullanıcı adı veya Şifre hatalı/boş")
        }
    }
}


