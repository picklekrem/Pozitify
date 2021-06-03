//
//  SignUpViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 3.06.2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    let firestoredatabase = Firestore.firestore()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

     
    @IBAction func signupClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authData, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please try again")
                }else {
                    let userDictionary = ["Email" : self.emailTextField.text!, "Password" : self.passwordTextField.text!] as [String : Any]
                    self.firestoredatabase.collection("Users").document(Auth.auth().currentUser!.email!).setData(userDictionary)
                    //perform segue
                    print("kullanıcı oluşturuldu")
                }
            }
        }
    }
    
}

extension UIViewController {
    func makeAlert(titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
