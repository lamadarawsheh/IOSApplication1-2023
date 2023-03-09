//
//  DetailsViewModel.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 08/03/2023.
//

import Foundation

class DetailsViewModel{
    
    var setUser: (()->())?
    
    private var User: UserCellModel? = nil {
        didSet {
            self.setUser?()
        }
    }
    
    
}
