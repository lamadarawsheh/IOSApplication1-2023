//
//  UserListViewModel.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 08/03/2023.
//

import Foundation


class UserListViewModel {
    var filteredUsers:[UserClass] = []
    var isSearching:Bool = false
    private let requestHandler =  RequestsHandler()
    var reloadTableView: (()->())?
    var updateLabel: (()->())?
    
    var users: [UserClass] = [UserClass]() {
        didSet {
            self.reloadTableView?()
        }
    }
    var notFoundLabelisHidden:Bool? = nil {
        didSet {
            self.updateLabel?()
        }
    }
    
    func fetchUsers(){
        requestHandler.getUsers(completionHandler: { [self]
            (result)-> Void  in
            for user in result
            {
                self.users.append(DataManager().saveUsers(user))
            }
            self.reloadTableView?()
            
        })
        
        
    }
    
    
    var numberOfCells: Int {
        if isSearching {
            return filteredUsers.count
        }
        else {
            return users.count
        }
    }
    
    
    func getUserCellInfo( at indexPath: IndexPath ) -> UserClass {
        
        if filteredUsers.isEmpty && isSearching == false
        {
            return users[indexPath.row]
        }
        else
        {
            return filteredUsers[indexPath.row]
            
        }
        
    }
    func updateSearchResults(_ text:String){
        filteredUsers.removeAll()
        isSearching = !text.isEmpty
        notFoundLabelisHidden = true
        if !text.isEmpty {
            filteredUsers = users.filter({ $0.u.name.localizedCaseInsensitiveContains(text) })
            notFoundLabelisHidden = !filteredUsers.isEmpty
        }
        
        self.reloadTableView?()
        
        
        
    }
    
}
