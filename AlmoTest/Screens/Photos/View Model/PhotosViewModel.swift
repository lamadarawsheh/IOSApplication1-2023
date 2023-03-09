//
//  PhotosViewModel.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 09/03/2023.
//

import Foundation

class PhotosViewModel {
    var photos:[Photo] = []
    var secPhotos:[Int:[Photo]] = [:]
    private let requestHandler =  RequestsHandler()
    
    var reloadcollectionView: (()->())?
    
    private var photosCells: [Photo] = [Photo]() {
        didSet {
            self.reloadcollectionView?()
        }
    }
    func excuteRequest()  {
        
        requestHandler.getPhotos(completionHandler: {
            (r)-> Void  in
            
            self.secPhotos = Dictionary(grouping: self.photos, by: \.ph.albumId)
            self.createCell(photos: r)
            self.reloadcollectionView!()
            
        })
        
    }
    
    
    func createCell(photos: [Photo]){
        self.photos = photos
        var vms = [Photo]()
        for photo in photos {
            vms.append(photo)
        }
        self.secPhotos = Dictionary(grouping: self.photos, by: \.ph.albumId)
        photosCells = vms
    }
    
}
