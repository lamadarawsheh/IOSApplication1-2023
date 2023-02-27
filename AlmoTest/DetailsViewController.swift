//
//  DetailsViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 22/02/2023.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet  var  usernameTextView :UITextView!
    @IBOutlet  var  emailTextView :UITextView!
    @IBOutlet  var  phoneTextView :UITextView!
    @IBOutlet  var  addressTextView :UITextView!


    var user:UserClass? = nil
    
    
    
    override func viewDidLoad() {
    
      
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
            title = (user?.u.username)!+"Details"
        usernameTextView.text = user?.u.username
        emailTextView.text = user?.u.email
        phoneTextView.text = user?.u.phone
        
        addressTextView.text = (user?.u.address.city)! + "-" + (user?.u.address.street)! + "-" + (user?.u.address.suite)! + "-"
        + (user?.u.address.zipcode)!
      
    }
 

}
