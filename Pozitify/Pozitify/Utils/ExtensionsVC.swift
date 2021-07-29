//
//  ExtensionsVC.swift
//  Pozitify
//
//  Created by Onur Başdaş on 3.06.2021.
//

import UIKit

fileprivate var aView : UIView?

extension UIViewController {
    func showSpinner(){
       aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }
    
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
