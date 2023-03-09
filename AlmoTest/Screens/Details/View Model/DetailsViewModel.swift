//
//  DetailsViewModel.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 08/03/2023.
//

import Foundation


class DetailsViewModel{
    var doublelat:Double = 0.0
    var doublelng:Double = 0.0
    var user: UserClass? = nil
    func getAddress()->String{
        let address:String = user!.u.address.city + "\n" + user!.u.address.street + "\n" + user!.u.address.suite + "\n" + user!.u.address.zipcode
        return address
    }
    
    func getLng()->Double{
        let lng = user!.u.address.geo.lng
        doublelng = Double(lng)!
        return doublelng
    }
    
    func getLat()->Double{
        let lat = user!.u.address.geo.lat
        doublelat = Double(lat)!
        return doublelat
    }
    
    
}
