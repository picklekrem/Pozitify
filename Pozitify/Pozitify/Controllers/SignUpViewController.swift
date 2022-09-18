//
//  SignUpViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 3.06.2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    let firestoreDatabase = Firestore.firestore()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAgainTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet var termsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        hideKeyboardWhenTappedAround()
    }
    
    func configureUI() {
        emailTextField.addBottomBorder()
        fullNameTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        passwordAgainTextField.addBottomBorder()
        signUpButton.isEnabled = false
    }
        
    @IBAction func signupClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" && fullNameTextField.text != "" {
            if passwordTextField.text == passwordAgainTextField.text {
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authData, error in
                    if error != nil {
                        self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please try again")
                    }else {
                        let userDictionary = ["userEmail" : self.emailTextField.text!,"userName" : self.fullNameTextField.text!, "userPassword" : self.passwordTextField.text!, "totalTaskComplete" : 0, "totalPoints" : 0] as [String : Any]
                        self.firestoreDatabase.collection("Users").document(Auth.auth().currentUser!.email!).setData(userDictionary)
                        self.loadScreen(name: "Auth", identifier: "settingUpVC")
                    }
                }
            } else {
                makeAlert(titleInput: "Passwords doesnt match!", messageInput: "please enter same passwords.")
            }
        } else {
            makeAlert(titleInput: "Hata!", messageInput: "Lütfen bütün boşlukları doldurunuz.")
        }
    }

    @IBAction func logInButtonClicked(_ sender: Any) {
        loadScreen(name: "Auth", identifier: "loginVC")
    }
    
    @IBAction func termsButton(_ sender: UISwitch) {
        if (sender.isOn == false) {
            signUpButton.isEnabled = false
        } else {
            signUpButton.isEnabled = true
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        emailTextField.resignFirstResponder()
//        passwordTextField.resignFirstResponder()
//        fullNameTextField.resignFirstResponder()
//        passwordAgainTextField.resignFirstResponder()
//        return(true)
//    }
}

class SettingUpProfileViewController : UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImageView.addGestureRecognizer(gestureRecognizer)
        profileImageView.roundedImage() 
    }
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        loadScreen(name: "Main", identifier: "tabBar")
    }
}
