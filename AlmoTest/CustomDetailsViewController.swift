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
//    @IBOutlet weak var imageIcon:UIImageView!
    
    @IBOutlet weak var usernameTextView: UITextView!
    
    @IBOutlet weak var emailTextView: UITextView!
    
    @IBOutlet weak var phoneTextView: UITextView!
    
    @IBOutlet weak var addressTextView: UITextView!
    
    @IBOutlet weak var mapKitView: MKMapView!
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
//        createStackView()
        self.imageIcon.layer.borderWidth = 1.0
        self.imageIcon.layer.masksToBounds = false
        self.imageIcon.layer.borderColor = UIColor.blue.cgColor
        var image = UIImage(named: "profile")
        imageIcon.image = image
        imageIcon.layer.cornerRadius = imageIcon.frame.size.width/2
      self.imageIcon.clipsToBounds = true
        

        
        title = (user?.u.name)!+" details"
    usernameTextView.text = user?.u.username
    emailTextView.text = user?.u.email
    phoneTextView.text = user?.u.phone
    
    addressTextView.text = (user?.u.address.city)! + "-" + (user?.u.address.street)! + "-" + (user?.u.address.suite)! + "-"
    + (user?.u.address.zipcode)!
        guard var lng = Double((user?.u.address.geo.lng)!) else { return  }
      guard  var lat = Double((user?.u.address.geo.lat)!) else
        {return }

        var initialLoc = CLLocation(latitude: lat, longitude: lng)
        setStartingLocation(location: initialLoc ,distance:1000)
        addAnnotation(lat,lng,user?.u.name)
        
    }
   
//    func createStackView(){
//        let stackView = UIStackView(arrangedSubviews: [mapKitView,imageIcon])
////        stackView.frame = view.frame
////        stackView.backgroundColor = .systemRed
//        stackView.axis = .vertical
////        stackView.distribution = .fillProportionally
////        stackView.spacing = 20
//        view.addSubview(stackView)
//
//
//
//    }
    func setStartingLocation(location:CLLocation,distance:CLLocationDistance){
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapKitView.setRegion(region, animated: true)
    }
    
    func addAnnotation(_ lat:Double,_ lng:Double ,_ name:String?){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        pin.title = name! + "'s current Address"
        mapKitView.addAnnotation(pin)
    }
    
    
}
