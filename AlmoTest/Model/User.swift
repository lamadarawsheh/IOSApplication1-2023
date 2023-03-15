//
//  User.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 21/02/2023.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone:String
    var address:Address
    var website:String
    var company:Company
    
    
}
struct Address:Codable{
    var street:String
    var suite:String
    var city:String
    var zipcode:String
    var geo:Geo
    
    
}
struct Geo:Codable{
    var lat:String
    var lng:String
    
}
struct Company:Codable{
    
    var name:String
    var catchPhrase:String
    var bs:String
}






class UserClass {
    
    var u:User
    var isFavorite:Bool
    init(u: User) {
        self.u = u
        isFavorite = false
    }
}
