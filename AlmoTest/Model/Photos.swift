//
//  Photos.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 22/02/2023.
//

import Foundation

struct SecPhotos {
    var albumId:Int
    var photos:[Photo]
}

struct Photos: Codable {
    var albumId:Int
    var id:Int
   var title: String
    var url:String
   var thumbnailUrl: String
  
   
}





class Photo {

    var ph:Photos
    
    init(ph: Photos) {
        self.ph = ph
    }
}
