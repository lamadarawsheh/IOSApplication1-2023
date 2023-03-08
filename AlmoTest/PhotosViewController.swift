//
//  PhotosViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 22/02/2023.
//

import UIKit
import SDWebImage


class PhotosViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate{
    @IBOutlet weak var collectionView:UICollectionView!
    let PhotoUrl:String = "photos"
    var photos:[Photo] = []
    var secPhotos:[Int:[Photo]] = [:]
    private let requestHandler =  RequestsHandler()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        excuteRequest()
        configureItems()
        
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
    func configureItems(){
        
        let EditButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        let image = SingeltonUser.User.image
        
        EditButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        EditButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        EditButton.layer.cornerRadius = EditButton.frame.width / 2
        EditButton.clipsToBounds = true
        EditButton.setBackgroundImage(image,for: .normal)
        
        EditButton.addTarget(self, action: #selector(goToEdit(sender: )), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: EditButton)
        

    }
    override func viewWillAppear(_ animated: Bool) {
        configureItems()
        
    }
    
    @objc func goToEdit(sender: UIBarButtonItem) {
        
        let editProfile  = self.storyboard?.instantiateViewController(identifier: "profile") as!   ProfileViewController
        let vc = UINavigationController(rootViewController: editProfile)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return secPhotos[section+1]!.count
        
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return secPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! photosCollectionViewCell
        
        let photos = secPhotos[indexPath.section+1]
        
        cell.label.text = String( photos![indexPath.row].ph.title)
        print (  photos![indexPath.row].ph.albumId)
        
        let url = URL(string: photos![indexPath.row].ph.thumbnailUrl)!
        cell.imageIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imageIcon.sd_imageIndicator?.startAnimatingIndicator()
        cell.imageIcon.sd_setImage(with: url, placeholderImage: UIImage(named: "moon"), options: .continueInBackground,completed: nil)
        
        return cell
    }
    
    func excuteRequest()  {
        
        requestHandler.getPhotos(completionHandler: {
            (r)-> Void  in
            
            self.photos = r
            
            self.secPhotos = Dictionary(grouping: self.photos, by: \.ph.albumId)
            
            self.collectionView.reloadData()
            
        })
        
        
        
    }
}
extension PhotosViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize(width: 400, height: 100)
        
        return CGSize(width: 150, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "photoheader", for: indexPath)as! PhotoCollectionReusableView
        let photos = secPhotos[indexPath.section+1]
        header.header.text = "Photos with Album Id = "+String( photos![indexPath.row].ph.albumId)
        
        
        return header
    }}
