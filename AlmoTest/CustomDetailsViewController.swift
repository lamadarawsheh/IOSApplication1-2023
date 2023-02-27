//
//  CustomDetailsViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 27/02/2023.
//

import Foundation
import UIKit
import MapKit
class CustomDetailsViewController: UIViewController {
    
    var user:UserClass? = nil
    
    
    @IBOutlet weak var usernameTextView: UITextView!
    
    @IBOutlet weak var emailTextView: UITextView!
    
    @IBOutlet weak var phoneTextView: UITextView!
    
    @IBOutlet weak var addressTextView: UITextView!
    
    @IBOutlet weak var mapKitView: MKMapView!
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        title = (user?.u.username)!+" details"
    usernameTextView.text = user?.u.username
    emailTextView.text = user?.u.email
    phoneTextView.text = user?.u.phone
    
    addressTextView.text = (user?.u.address.city)! + "-" + (user?.u.address.street)! + "-" + (user?.u.address.suite)! + "-"
    + (user?.u.address.zipcode)!
  
    }
}
