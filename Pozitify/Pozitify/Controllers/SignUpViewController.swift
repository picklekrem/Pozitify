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
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAgainTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" && fullNameTextField.text != "" {
            if passwordTextField.text == passwordAgainTextField.text {
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authData, error in
                    if error != nil {
                        self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please try again")
                    }else {
                        let userDictionary = ["Email" : self.emailTextField.text!,"Full Name" : self.fullNameTextField.text!, "Password" : self.passwordTextField.text!] as [String : Any]
                        self.firestoredatabase.collection("Users").document(Auth.auth().currentUser!.email!).setData(userDictionary)
                        //self.performSegue(withIdentifier: "toSettingUp", sender: nil)
                        self.loadScreen(name: "Auth", identifier: "settingUpVC")
                    }
                }
            } else {
                makeAlert(titleInput: "Passwords doesnt match!", messageInput: "please enter same passwords.")
            }
        }
    }
    
    @IBAction func termsButton(_ sender: UISwitch) {
        if (sender.isOn == false) {
            signUpButton.isEnabled = false
        }
        else {
            signUpButton.isEnabled = true
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        fullNameTextField.resignFirstResponder()
        passwordAgainTextField.resignFirstResponder()
        return(true)
    }
}

class SettingUpProfileViewController : UIViewController {
    
    let firestoredatabase = Firestore.firestore()
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImageView.addGestureRecognizer(gestureRecognizer)
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

extension SettingUpProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = image
            let imageData : NSData =  (image.pngData() as NSData?)!
            UserDefaults().setValue(imageData, forKey: "profilePicture")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
