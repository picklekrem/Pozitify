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
//        getTasksData()
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
//                        FAZ2 - TOTAL POINTS ADD
                        let userDictionary = ["userEmail" : self.emailTextField.text!,"userName" : self.fullNameTextField.text!, "userPassword" : self.passwordTextField.text!, "totalTaskComplete" : 0, "ideaCount" : 0] as [String : Any]
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
}

class SettingUpProfileViewController : UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    private var tasks : TaskContainerList?
    let firestoreDatabase = Firestore.firestore()
    let userOnline = Auth.auth().currentUser!.email!
    let webService = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        profileImageView.addGestureRecognizer(gestureRecognizer)
        profileImageView.roundedImage()
        getTasksData()
    }
    
    func getTasksData() {
        webService.getTaskData { response in
            switch response {
            case .success(let tasks):
                var userDictionary = [:] as [String : Any]
                guard let tasks = tasks else {return}
//                self.createRandomTaskList(tasks: tasks)
                
                let randomTasks = tasks.choose(3)
                
                do {
                    tasks.forEach({ x in
                        userDictionary["taskInfo"] = x.taskInfo
                        userDictionary["taskId"] = x.taskId
                        userDictionary["taskTitle"] = x.taskTitle
                        userDictionary["isComplete"] = x.isComplete
                        userDictionary["createdDate"] = ""
                        
                        self.firestoreDatabase.collection("Users").document(self.userOnline).collection("Tasks").document(x.taskId).setData(userDictionary)
                        if randomTasks[0].taskId == x.taskId || randomTasks[1].taskId == x.taskId || randomTasks[2].taskId == x.taskId {
                            let date = Date()
                            userDictionary["createdDate"] = date.dateToString()
                            self.firestoreDatabase.collection("Users").document(self.userOnline).collection("CurrentTasks").document(x.taskId).setData(userDictionary)
                        } else {
                            self.firestoreDatabase.collection("Users").document(self.userOnline).collection("WaitingTasks").document(x.taskId).setData(userDictionary)
                        }
                    })
                } catch let error {
                    print("Error from Firestore: \(error)")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func createRandomTaskList (tasks : [TaskContainerList]) {
//        let randomTasks = tasks.choose(3)
//        var userDictionary = [:] as [String : Any]
//        randomTasks.forEach { x in
//
//            userDictionary["taskInfo"] = x.taskInfo
//            userDictionary["taskId"] = x.taskId
//            userDictionary["taskTitle"] = x.taskTitle
//            userDictionary["isComplete"] = x.isComplete
//
//            self.firestoreDatabase.collection("Users").document(self.userOnline).collection("CurrentTasksFunction").document(x.taskId).setData(userDictionary)
//
//            randomTasks.filter { word in
//                if x.taskId == word.taskId {
//                    self.firestoreDatabase.collection("Users").document(self.userOnline).collection("CurrentTasksFilter").document(x.taskId).setData(userDictionary)
//                }
//                return true
//            }
//        }
//    }
    
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
