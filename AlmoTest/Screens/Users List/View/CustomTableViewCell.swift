//
//  CustomTableViewCell.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 22/02/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    var user:UserClass? = nil{
        didSet {
            if let user = user {
                nameLabel.text = user.u.name
                usernameLabel.text = user.u.username
                setImage()
                self.accessoryType = .disclosureIndicator
            }
            
        }
    }
    
    
    
    
    func setImage(){
        
        
        imageIcon.layer.borderWidth = 1.0
        imageIcon.layer.masksToBounds = false
        imageIcon.layer.borderColor = UIColor.blue.cgColor
        let image = UIImage(named: "profile")
        imageIcon.image = image
        imageIcon.layer.cornerRadius = imageIcon.frame.size.width/2
        imageIcon.clipsToBounds = true
        
        
        
    }
    
    
    
}
