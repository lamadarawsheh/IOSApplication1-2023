//
//  PhotosViewModel.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 09/03/2023.
//

import Foundation
import UIKit
import CoreData

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
            (succeeded,result)-> Void  in
            if succeeded
            {
                for photo in result
                {
                    self.photos.append(photo)
                    DataManager().savePhoto(photo)
                }
                self.secPhotos = Dictionary(grouping: self.photos, by: \.ph.albumId)
                self.reloadcollectionView?()
            }
            else {
                self.photos = DataManager().fetchPhotos()
                self.secPhotos = Dictionary(grouping: self.photos, by: \.ph.albumId)
                self.reloadcollectionView?()
            }
        })
        
    }
    
    
    
    
}
