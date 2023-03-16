//
//  DetailsViewModel.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 08/03/2023.
//

import Foundation


class DetailsViewModel{
    var user: UserClass? = nil
    var userListViewModel:UserListViewModel? = nil
    func getAddress()->String{
        let address:String = user!.u.address.city + "\n" + user!.u.address.street + "\n" + user!.u.address.suite + "\n" + user!.u.address.zipcode
        return address
    }
    
    func getLng()->Double{
        let lng = user!.u.address.geo.lng
        let doublelng = Double(lng)!
        return doublelng
    }
    
    func getLat()->Double{
        let lat = user!.u.address.geo.lat
        let doublelat = Double(lat)!
        return doublelat
    }
    func isfavourite()->Bool{
        let result = userListViewModel?.users.first(where: {$0.u.id == user!.u.id})
        return result!.isFavorite
    }
    func toggleFavoriteState(){
        userListViewModel?.toggleFavoriteState(user!)
    }
    
    
}
