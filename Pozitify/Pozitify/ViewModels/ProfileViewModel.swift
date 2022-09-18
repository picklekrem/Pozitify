//
//  ProfileViewModel.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 4.07.2022.
//

import UIKit

class ProfileViewModel: NSObject {
    
    var didGetUserInfoFetched : (UserInfoList) -> () = { result in}
    
    func getUserInfo() {
        WebService().getUserInfo { userInfoList in
            guard let userInfoList = userInfoList else {
                return
            }
            self.didGetUserInfoFetched(userInfoList)
        }
    }
}
