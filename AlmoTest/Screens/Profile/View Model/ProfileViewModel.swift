//
//  ProfileViewModel.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 09/03/2023.
//

import Foundation
class ProfileViewModel {
    
    var isNameEdited:Bool = false
    var isUserNameEdited:Bool = false
    var isEmailEdited:Bool = false
    
    func checkNameField (_ text:String){
        isNameEdited = !text.isEmpty
    }
    func checkUserNameField (_ text:String){
        isUserNameEdited = !text.isEmpty
        
    }
    func checkEmailField (_ text:String){
        isEmailEdited = !text.isEmpty
        
    }
    func saveButtonEnabeled()->Bool{
        return (isNameEdited == true && isUserNameEdited == true && isEmailEdited == true)
    }
    
    
    
    
}
