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
    
    func getUserInfo() {
//        WebService().getUserInfo { userInfoList in
//            guard let userInfoList = userInfoList else {
//                return
//            }
//            self.didGetUserInfoFetched(userInfoList)
        webService.getUserInfo { response in
            switch response {
            case.success(let userInfoList):
                guard let userInfoList = userInfoList else {return}
                self.didGetUserInfoFetched(userInfoList)
            case .failure(let error):
                print(error.localizedDescription)
        }
        }
    }
}
