//
//  WebService.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 2.08.2021.
//

import Foundation
import Firebase

class WebService {
    let firestoreDatabase = Firestore.firestore()
    let decoder = JSONDecoder()
    let userEmail = Auth.auth().currentUser?.email
    func getUserInfo(completion : @escaping (UserInfoList?) -> ()){
        firestoreDatabase.collection("Users").document("\(userEmail!)").getDocument { querySnapshot, error in
            if let error = error {print(error.localizedDescription)}
            else {
                do {
                    let jsonData = try? JSONSerialization.data(withJSONObject: querySnapshot!.data() ?? "")
                    let userModel = try self.decoder.decode(UserInfoList.self, from: jsonData!)
                    completion(userModel)
                } catch let err {
                    print(err)
                }
            }
        }
    }
    func getTaskData(completion : @escaping (TaskContainerList?) -> ()){
        firestoreDatabase.collection("Tasks").getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    do {
                        let jsonData = try? JSONSerialization.data(withJSONObject: document.data())
                        let taskModel = try self.decoder.decode(TaskContainerList.self, from: jsonData!)
                        print(taskModel)
                        completion(taskModel)
                    } catch let err {
                        print(err)
                    }
                }
            }
        }
    }
}
