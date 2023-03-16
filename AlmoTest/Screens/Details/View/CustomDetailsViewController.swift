//
//  CustomDetailsViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 27/02/2023.
//


import UIKit
import MapKit
class CustomDetailsViewController: UIViewController {
    
    var user:UserClass? = nil
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var usernameTextView: UITextView!
    
    @IBOutlet weak var emailTextView: UITextView!
    
    @IBOutlet weak var phoneTextView: UITextView!
    
    @IBOutlet weak var addressTextView: UITextView!
    
    @IBOutlet weak var mapKitView: MKMapView!
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    var detailsViewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setImage()
        
        if let User = user{
            setFavoriteButton()
            title = (User.u.name)+" details"
            usernameTextView.text = User.u.username
            emailTextView.text = User.u.email
            phoneTextView.text = User.u.phone
            
            addressTextView.text = detailsViewModel.getAddress()
            
            let  initialLoc = CLLocation(latitude:detailsViewModel.getLat() , longitude: detailsViewModel.getLng() )
            
            setStartingLocation(location: initialLoc ,distance:1000)
            addAnnotation(detailsViewModel.getLat() ,detailsViewModel.getLng() , User.u.name)
            
        }
        
        
        
        
    }
    
    func setImage(){
        self.imageIcon.layer.borderWidth = 1.0
        self.imageIcon.layer.masksToBounds = false
        self.imageIcon.layer.borderColor = UIColor.blue.cgColor
        let image = UIImage(named: "profile")
        imageIcon.image = image
        imageIcon.layer.cornerRadius = imageIcon.frame.size.width/2
        self.imageIcon.clipsToBounds = true
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
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        detailsViewModel.toggleFavoriteState()
        setFavoriteButton()
        
    }
    func setFavoriteButton (){
        favoriteButton.setTitle("", for: .normal)
        
        
        if detailsViewModel.isfavourite()
        {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            favoriteButton.tintColor = .systemYellow
        }
        else
        {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            favoriteButton.tintColor = .systemGray
        }
        
        
    }
}
