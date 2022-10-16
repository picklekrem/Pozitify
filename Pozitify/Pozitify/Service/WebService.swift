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
    
    enum APIError : Error {
        case failedToGetData
    }
    
    func getUserInfo(completion : @escaping (Result<UserInfoList?, Error>) -> ()) {
        firestoreDatabase.collection("Users").document("\(userEmail!)").getDocument { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(APIError.failedToGetData))
            }
            else {
                do {
                    let jsonData = try? JSONSerialization.data(withJSONObject: querySnapshot!.data() ?? "")
                    let userModel = try self.decoder.decode(UserInfoList.self, from: jsonData!)
                    completion(.success(userModel))
                } catch let err {
                    print(err)
                }
            }
        }
    }
    
    func getTaskData(completion : @escaping (Result <[TaskContainerList]?, Error>) -> ()) {
        firestoreDatabase.collection("Tasks").getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(APIError.failedToGetData))
            } else {
                var tasks : [TaskContainerList] = []
                for document in querySnapshot!.documents {
                    do {
                        let jsonData = try? JSONSerialization.data(withJSONObject: document.data())
                        let taskModel = try self.decoder.decode(TaskContainerList.self, from: jsonData!)
                        tasks.append(taskModel)
                       
                    } catch let err {
                        print(err)
                    }
                }
                completion(.success(tasks))
            }
        }
    }
    func getTaskDataFromProfile(completion : @escaping (Result <[TaskContainerList]?, Error>) -> ()) {
        let user = Auth.auth().currentUser!.email!
        firestoreDatabase.collection("Users").document(user).collection("CurrentTasks").getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(APIError.failedToGetData))
            } else {
                var tasks : [TaskContainerList] = []
                for document in querySnapshot!.documents {
                    do {
                        let jsonData = try? JSONSerialization.data(withJSONObject: document.data())
                        let taskModel = try self.decoder.decode(TaskContainerList.self, from: jsonData!)
                        tasks.append(taskModel)
                       
                    } catch let err {
                        print(err)
                    }
                }
                completion(.success(tasks))
            }
        }
    }
    
}
