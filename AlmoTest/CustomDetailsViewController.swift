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
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()

        self.imageIcon.layer.borderWidth = 1.0
        self.imageIcon.layer.masksToBounds = false
        self.imageIcon.layer.borderColor = UIColor.blue.cgColor
        let image = UIImage(named: "profile")
        imageIcon.image = image
        imageIcon.layer.cornerRadius = imageIcon.frame.size.width/2
        self.imageIcon.clipsToBounds = true
        
        if let User = user{
            title = (User.u.name)+" details"
            usernameTextView.text = User.u.username
            emailTextView.text = User.u.email
            phoneTextView.text = User.u.phone
        
            addressTextView.text = User.u.address.city + "\n" + User.u.address.street + "\n" + User.u.address.suite + "\n" + User.u.address.zipcode
            
             let lng = User.u.address.geo.lng
                
            let lat = User.u.address.geo.lat
            let doublelng:Double = Double(lng)!
            let doublelat:Double = Double(lat)!
            let  initialLoc = CLLocation(latitude:doublelat , longitude: doublelng )
            setStartingLocation(location: initialLoc ,distance:1000)
            addAnnotation(doublelat ,doublelng , User.u.name)

        }

        
      
        
    }

    func setStartingLocation(location:CLLocation,distance:CLLocationDistance){
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapKitView.setRegion(region, animated: true)
    }
    
    func addAnnotation(_ lat:Double,_ lng:Double ,_ name:String){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        pin.title = name + "'s current Address"
        mapKitView.addAnnotation(pin)
    }
    
    
}
