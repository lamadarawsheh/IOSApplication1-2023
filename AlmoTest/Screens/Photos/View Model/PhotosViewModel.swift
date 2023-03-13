//
//  PhotosViewModel.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 09/03/2023.
//

import Foundation

class PhotosViewModel {
    var secPhotos:[Int:[Photo]] = [:]
    private let requestHandler =  RequestsHandler()
    
    var reloadcollectionView: (()->())?
    
    var photos: [Photo] = [Photo]() {
        didSet {
            self.reloadcollectionView?()
        }
    }
    func excuteRequest()  {
        
        requestHandler.getPhotos(completionHandler: {
            (result)-> Void  in
            for photo in result
            {
                self.photos.append(DataManager().savePhotos(photo))
            }
            self.secPhotos = Dictionary(grouping: self.photos, by: \.ph.albumId)
            self.reloadcollectionView?()
            
        })
        
    }
    
    
    
    
}
