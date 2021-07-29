//
//  IdeasViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 1.06.2021.
//

import UIKit
import Firebase

class IdeasViewController: UIViewController, UITextViewDelegate {
    
    let firestoredatabase = Firestore.firestore()
    
    @IBOutlet var backView: UIView!
    @IBOutlet var ideasView: UIView!
    @IBOutlet var titleTextView: UITextView!
    @IBOutlet var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let defaults = UserDefaults.standard
//        let myarray = defaults.object(forKey: "myKey") as! [String : String]
        let deneme = [defaults.dictionary(forKey: "myKey")]
        print(deneme[1])
    }
    
    func configureUI() {
        ideasView.layer.shadowColor = UIColor.gray.cgColor
        ideasView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        ideasView.layer.shadowOpacity = 1.0
        ideasView.layer.masksToBounds = false
        ideasView.layer.cornerRadius = 8
        titleTextView.layer.cornerRadius = 8
        titleTextView.text = "Tell us the things that makes you happy in your daily life so we can share them with other people!"
        titleTextView.textColor = UIColor.lightGray
        submitButton.layer.cornerRadius = 24
    }
    
    func textViewDidBeginEditing(_ textview: UITextView) {
        if textview.textColor == UIColor.lightGray {
            textview.text = nil
            textview.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textview: UITextView) {
        if textview.text == "" {
            textview.text = "Tell us the things that makes you happy in your daily life so we can share them with other people!"
            textview.textColor = UIColor.lightGray
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextView.resignFirstResponder()
        return(true)
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        let ideaPost = ["Idea" : titleTextView.text!, "Email" : Auth.auth().currentUser?.email!] as [String : Any]
        firestoredatabase.collection("Ideas").addDocument(data: ideaPost) { error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error" )
            } else {
                self.makeAlert(titleInput: "Thank you! :)", messageInput: "Thanks for your kind idea :)")
                self.titleTextView.text = ""
                self.tabBarController?.selectedIndex = 0
            }
        }
        
    }
}
