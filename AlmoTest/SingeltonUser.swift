//
//  SingeltonUser.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 05/03/2023.
//

import Foundation
import UIKit
class SingeltonUser{
    
    static let User = SingeltonUser()
    var name:String = ""
    var username:String = ""
    var email:String = ""
    var address:String = ""
    var image:UIImage = UIImage(systemName: "person.crop.circle.badge.plus")!
    

    
    private init(){}
    
    func setuser(_ name:String,_ username:String, _ email:String ,_ address:String ,_ image:UIImage){
        self.name = name
        self.username = username
        self.address = address
        self.email = email
        self.image = image
    }
   
    
}
