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
    
    private var cellViewModels: [PhotoCellModel] = [PhotoCellModel]() {
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
        var vms = [PhotoCellModel]()
        for photo in photos {
            vms.append(PhotoCellModel(photo: photo))
        }
        self.secPhotos = Dictionary(grouping: self.photos, by: \.ph.albumId)
        cellViewModels = vms
    }
    
    
//    var numberOfCells: Int {
//
//
//
//        if (filteredUsers.isEmpty && isSearching == false)
//        {
////            return self.users.count
//            return cellViewModels.count
//        }
//
//        else if (filteredUsers.isEmpty && isSearching == true)
//        {
//            return 1
//        }
//        else
//        {
//            return self.filteredUsers.count
//        }
//
//    }

    func getCellViewModel( at indexPath: IndexPath ) -> PhotoCellModel {
        return cellViewModels[indexPath.row]
    }
    

 
    
}
