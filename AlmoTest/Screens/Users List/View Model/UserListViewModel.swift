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
    
    private var cellViewModels: [UserCellModel] = [UserCellModel]() {
        didSet {
            self.reloadTableView?()
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
        var vms = [UserCellModel]()
        for user in users {
            vms.append(UserCellModel(user: user))
        }
        cellViewModels = vms
    }
    
    var numberOfCells: Int {
        
        
        
        if (filteredUsers.isEmpty && isSearching == false)
        {
//            return self.users.count
            return cellViewModels.count
        }
        
        else if (filteredUsers.isEmpty && isSearching == true)
        {
            return 1
        }
        else
        {
            return self.filteredUsers.count
        }
        
    }

    func getCellViewModel( at indexPath: IndexPath ) -> UserCellModel {
        return cellViewModels[indexPath.row]
    }
    func updateSearchResults(_ text:String){
        filteredUsers.removeAll()
        
            if !(text.isEmpty)
            {
                filteredUsers = users.filter({ $0.u.name.localizedCaseInsensitiveContains(text) })
                isSearching = true
            }
            else
            {
                isSearching = false
            }
            
            self.reloadTableView!()
        
        
        
    }
 
    
}
