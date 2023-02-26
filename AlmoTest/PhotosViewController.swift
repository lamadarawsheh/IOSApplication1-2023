//
//  PhotosViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 22/02/2023.
//

import UIKit
import SDWebImage


class PhotosViewController: UIViewController ,UICollectionViewDataSource{
    @IBOutlet weak var collectionView:UICollectionView!
    let PhotoUrl:String = "photos"
    var photos:[Photo] = []
    private let requestHandler =  RequestsHandler()
    override func viewDidLoad() {
      
        super.viewDidLoad()
        excuteRequest()
        
       
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
//        cell.imageIcon.image = UIImage(named: "moon")
        
        let url = URL(string:   photos[indexPath.row].ph.thumbnailUrl)!
        cell.imageIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imageIcon.sd_imageIndicator?.startAnimatingIndicator()
        cell.imageIcon.sd_setImage(with: url, placeholderImage: UIImage(named: "moon"), options: .continueInBackground,completed: nil)
        //             downloadImage(from: url)
        //            cell.imageIcon.image =
        //
        return cell
    }
    func excuteRequest()  {

        
        requestHandler.getRequest(PhotoUrl,completion: {
            (r)-> Void  in

           
            let decoder = JSONDecoder()
            let json = Data(r.utf8)
            do {
                let photos: [Photos] = try!JSONDecoder().decode([Photos].self,from:json)
                
                for ph in photos {
                    let t = Photo(ph: ph)
                    
                    self.photos.append(t)
                
                    
                       }
                self.collectionView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
           
        })
        
        
        
    }
}
extension PhotosViewController:UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: 180, height: 300)
    }
}
