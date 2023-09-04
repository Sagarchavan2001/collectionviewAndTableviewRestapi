//
//  userModal.swift
//  MachinTest
//
//  Created by STC on 01/09/23.
//

import Foundation
struct UserApiResponce: Decodable{
    let data : [UserData]
}
struct UserData : Decodable{
    let id : Int
    let email, firstName, lastName: String
    let avatar: String
    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

