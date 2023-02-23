//
//  PhotosViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 22/02/2023.
//

import UIKit

class PhotosViewController: UIViewController ,UICollectionViewDataSource{
    @IBOutlet weak var collectionView:UICollectionView!
    let PhotoUrl:String = "photos"
    var photos:[Photo] = []
    override func viewDidLoad() {
      
        super.viewDidLoad()
        Task {
            try await excuteRequest()
        }
       
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! photosCollectionViewCell
        
        cell.label.text = photos[indexPath.row].ph.title
        cell.imageIcon.image = UIImage(named: "moon")
        
        let url = URL(string:   photos[indexPath.row].ph.thumbnailUrl)!
        
        //             downloadImage(from: url)
        //            cell.imageIcon.image =
        //
        return cell
    }
    func excuteRequest() async throws {
        let r = RequestsHandler()
        
        async let getValue = r.getRequest(PhotoUrl)
        
        let responses = try await (getValue)
        
        let json = responses.data(using: .utf8)!
        let photos: [Photos] = try!JSONDecoder().decode([Photos].self,from:json)
        
        for ph in photos {
            let t = Photo(ph: ph)
            
            self.photos.append(t)
        }
        
        self.collectionView.reloadData()
        
        
    }
}
extension PhotosViewController:UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: 180, height: 300)
    }
}
