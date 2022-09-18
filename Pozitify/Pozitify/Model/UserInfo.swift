//
//  UserInfo.swift
//  Pozitify
//
//  Created by Ekrem Özkaraca on 2.08.2021.
//

import Foundation

struct UserInfoList : Codable {
    let userName : String?
    let userEmail : String?
    let userPassword : String?
    let totalTaskComplete : Int?
    let totalPoints : Int?
}
