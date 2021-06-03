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
                        self.performSegue(withIdentifier: "toSettingUp", sender: nil)
                    }
                }
            } else {
                makeAlert(titleInput: "Passwords doesnt match!", messageInput: "please enter same passwords.")
            }
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
}

extension UIViewController {
    func makeAlert(titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
extension SettingUpProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
