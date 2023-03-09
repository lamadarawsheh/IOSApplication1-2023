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
        if(!text.isEmpty)
        {
            isNameEdited = true
            
        }
        else
        {
            isNameEdited = false
        }
    }
    func checkUserNameField (_ text:String){
        if(!text.isEmpty)
        {
            isUserNameEdited = true
            
        }
        else
        {
            isUserNameEdited = false
        }
        
    }
    func checkEmailField (_ text:String){
        if(!text.isEmpty)
        {
            isEmailEdited = true
            
        }
        else
        {
            isEmailEdited = false
        }
        
    }
    func saveButtonEnabeled()->Bool{
        if(isNameEdited == true && isUserNameEdited == true && isEmailEdited == true)
        { return true
        }
        else {
            return false
        }
        
    }
    
    
    
    
}
