//
//  UserListViewModel.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 08/03/2023.
//

import Foundation

class UserListViewModel {
    var users:[UserClass] = []
    var filteredUsers:[UserClass] = []
    var isSearching:Bool = false
    private let requestHandler =  RequestsHandler()
    var reloadTableView: (()->())?
    var updateLabel: (()->())?
    
    private var usersCells: [UserClass] = [UserClass]() {
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
        
        requestHandler.getUsers(completionHandler: {
            (r)-> Void  in
            
            
            self.createCell(users: r)
            self.reloadTableView!()
            
        })
        
    }
    func createCell(users: [UserClass]){
        self.users = users
        var vms = [UserClass]()
        for user in users {
            vms.append(user)
        }
        usersCells = vms
    }
    
    var numberOfCells: Int {
        if (filteredUsers.isEmpty && isSearching == false)
        {
            
            return usersCells.count
        }
        
        else if (filteredUsers.isEmpty && isSearching == true)
        {
            return 0
        }
        else
        {
            return self.filteredUsers.count
        }
        
    }
    
    
    func getUserCellInfo( at indexPath: IndexPath ) -> UserClass {
        if (filteredUsers.isEmpty && isSearching == false)
        {
            
            return usersCells[indexPath.row]
            
        }
        else
        {
            return filteredUsers[indexPath.row]
            
        }
        
    }
    func updateSearchResults(_ text:String){
        filteredUsers.removeAll()
        
        if !(text.isEmpty)
        {
            filteredUsers = users.filter({ $0.u.name.localizedCaseInsensitiveContains(text) })
            isSearching = true
            if (filteredUsers.isEmpty)
            {
                notFoundLabelisHidden = false
            }
            else {
                notFoundLabelisHidden = true
            }
        }
        else
        {
            isSearching = false
            notFoundLabelisHidden = true
        }
        
        self.reloadTableView!()
        
        
        
    }
    
    
}
