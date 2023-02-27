//
//  User.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 21/02/2023.
//

import Foundation

struct User: Codable {
   let id: Int
   var name: String
   let username: String
   let email: String
    let phone:String
    let address:Address
    let website:String
    let company:Company
    
   
}
struct Address:Codable{
    let street:String
    let suite:String
    let city:String
    let zipcode:String
    let geo:Geo
    
    
}
struct Geo:Codable{
    let lat:String
    let lng:String
    
}
struct Company:Codable{
    
    let name:String
    let catchPhrase:String
    let bs:String
}






class UserClass {

    var u:User
    
    init(u: User) {
        self.u = u
    }
}
