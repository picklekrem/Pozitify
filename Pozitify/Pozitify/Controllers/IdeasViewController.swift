//
//  IdeasViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 1.06.2021.
//

import UIKit
import Firebase

class IdeasViewController: UIViewController, UITextViewDelegate {
    
    let firestoreDatabase = Firestore.firestore()
    
    @IBOutlet var backView: UIView!
    @IBOutlet var ideasView: UIView!
    @IBOutlet var titleTextView: UITextView!
    @IBOutlet var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureUI()
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
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if titleTextView.text == "" || titleTextView.text == "Tell us the things that makes you happy in your daily life so we can share them with other people!" {
            self.makeAlert(titleInput: "Hata!", messageInput: "Idea part cannot be sent empty, please type your idea and sent again")
        } else {
            let ideaPost = ["Idea" : titleTextView.text!, "Email" : Auth.auth().currentUser?.email!] as [String : Any]
            firestoreDatabase.collection("Ideas").addDocument(data: ideaPost) { error in
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
}
