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
    let userEmail = Auth.auth().currentUser!.email!
    
    @IBOutlet var backView: UIView!
    @IBOutlet var ideasView: UIView!
    @IBOutlet var titleTextView: UITextView!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ideas_title".localized
        shareLabel.text = "share".localized
        submitButton.setTitle( "sumbit".localized, for: .normal)
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
        titleTextView.text = "ideas_placeholder".localized
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
            textview.text = "ideas_placeholder".localized
            textview.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if titleTextView.text == "" || titleTextView.text == "ideas_placeholder".localized {
            self.makeAlert(titleInput: "error".localized, messageInput: "error_idea".localized)
        } else {
            let ideaPost = ["Idea" : titleTextView.text!, "Email" : userEmail] as [String : Any]
            firestoreDatabase.collection("Ideas").addDocument(data: ideaPost) { error in
                if error != nil {
                    self.makeAlert(titleInput: "error".localized, messageInput: error?.localizedDescription ?? "Error" )
                } else {
                    self.makeAlert(titleInput: "thank_you".localized, messageInput: "thank_you_idea".localized)
                    self.titleTextView.text = ""
                    self.tabBarController?.selectedIndex = 0
                }
            }
        }
    }
}
