//
//  ProfileViewModel.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 4.07.2022.
//

import UIKit

class ProfileViewModel: NSObject {
    let webService = WebService()
    var didGetUserInfoFetched : (UserInfoList) -> () = { result in}
    var didTotalTaskComplete : (Int) -> () = {count in}
    func getUserInfo() {
        webService.getUserInfo { response in
            switch response {
            case.success(let userInfoList):
                guard let userInfoList = userInfoList else {return}
                print(userInfoList)
                self.didGetUserInfoFetched(userInfoList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getUserTaskInfo () {
        webService.getTaskDataFromProfile(listName: .tasks) { response in
            switch response {
            case.success(let userTasksInfo):
                guard let userTasksInfo = userTasksInfo else {return}
                self.didTotalTaskComplete(self.totalTaskComplete(tasks: userTasksInfo))
                
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
    func totalTaskComplete (tasks : [TaskContainerList]) -> Int {
        var totalNumer = 0
        tasks.forEach { task in
            if task.isComplete {
                totalNumer += 1
            }
        }
        return totalNumer
    }
}
