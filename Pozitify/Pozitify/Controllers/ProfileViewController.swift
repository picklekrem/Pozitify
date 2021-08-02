//
//  ProfileViewController.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 1.06.2021.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var userInfoList : UserInfoList?
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePictureUpload()
        
        nameLabel.text = "Ekrem"
        infoLabel.text = Auth.auth().currentUser?.email!
        getUserInfo()
    }
    func getUserInfo(){
        WebService().getUserInfo { userInfoList in
            print(userInfoList!)
            self.nameLabel.text = userInfoList?.Email
        }
    }
    
    func profilePictureUpload() {
        profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImageView.addGestureRecognizer(gestureRecognizer)
        let profilePic = UserDefaults.standard.object(forKey: "profilePicture") as? NSData
        if profilePic == nil {
            profileImageView.image = UIImage(named: "profilePlaceHolder")
        }else {
            profileImageView.image = UIImage(data: profilePic! as Data)
        }
        profileImageView.roundedImage()
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.loadScreen(name: "Auth", identifier: "loginVC")
        }catch{
            print("error")
        }
    }
}

extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
}
