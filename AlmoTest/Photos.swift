//
//  Photos.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 22/02/2023.
//

import Foundation
//
//  User.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 21/02/2023.
//


struct Photos: Codable {
    let albumId:Int
    let id:Int
   let title: String
    let url:String
   let thumbnailUrl: String
  
   
}





class Photo {

    var ph:Photos
    
    init(ph: Photos) {
        self.ph = ph
    }
}
