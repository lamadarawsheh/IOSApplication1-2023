//
//  PhotoProfileViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 06/03/2023.
//

import UIKit

class PhotoProfileViewController: UIViewController {
    
    @IBOutlet var imageIcon:UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
  
    
    override func viewDidLoad() {
     
        
        imageIcon.layer.borderWidth = 1.0
        imageIcon.layer.masksToBounds = false
        imageIcon.layer.cornerRadius = imageIcon.frame.size.width/2
        imageIcon.clipsToBounds = true
        setElements()
        super.viewDidLoad()
    }
    
    
    
    func setElements (){
        nameTextField.text = SingeltonUser.User.name
        usernameTextField.text = SingeltonUser.User.username
        emailTextField.text = SingeltonUser.User.email
        addressTextField.text = SingeltonUser.User.address
        imageIcon.image = SingeltonUser.User.image
        
      
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("SingeltonUser.User.name")
        setElements()
        
    }
  

}
