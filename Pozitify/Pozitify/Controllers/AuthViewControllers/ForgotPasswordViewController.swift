//
//  ForgotPasswordViewController.swift
//  Pozitify
//
//  Created by Onur Başdaş on 2.08.2021.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet var forgotEmailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendRequestClicked(_ sender: Any) {
        if forgotEmailText.text == "" {
            makeAlert(titleInput: "Hata!", messageInput: "Lütfen geçerli bir e-mail adresi giriniz")
        } else {
            Auth.auth().sendPasswordReset(withEmail: forgotEmailText.text!) { error in
                if error != nil {
                    self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Tekrar deneyiniz.")
                }
                self.makeAlert(titleInput: "Başarılı", messageInput: "Emailinize sıfırlama maili gönderilmiştir.")
            }
        }
    }
}
