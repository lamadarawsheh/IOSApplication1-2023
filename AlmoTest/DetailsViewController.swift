//
//  DetailsViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 22/02/2023.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet  var  usernamelabel :UITextView!
    @IBOutlet  var  emaillabel :UITextView!
    @IBOutlet  var  phonelabel :UITextView!
    @IBOutlet  var  addresslabel :UITextView!

    var name:String = " "
    var email:String = " "
    var phone:String = " "
    var address:String = " "
    var user:UserO? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
            title = "Details"
        usernamelabel.text = user?.u.username
        emaillabel.text = user?.u.email
        phonelabel.text = user?.u.phone
        
        addresslabel.text = (user?.u.address.city)! + "-" + (user?.u.address.street)! + "-" + (user?.u.address.suite)! + "-"
        + (user?.u.address.zipcode)!
      
    }
 

}
