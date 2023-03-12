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
