//
//  ExtensionsVC.swift
//  Pozitify
//
//  Created by Onur Başdaş on 3.06.2021.
//

import UIKit

extension UIViewController {
    func loadScreen(name: String, identifier : String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
        let destinationController = storyBoard.instantiateViewController(identifier: identifier)
        destinationController.modalPresentationStyle = .fullScreen
        destinationController.modalTransitionStyle = .crossDissolve
        self.present(destinationController, animated: true, completion: nil)
    }
    
    func makeAlert(titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
