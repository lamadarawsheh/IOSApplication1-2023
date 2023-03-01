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
        
       
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(section)
//        return ((secPhotos[section+1]?.count)!)
        return secPhotos[section+1]!.count
        
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return secPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! photosCollectionViewCell
        
//        cell.label.text = String (secPhotos[(indexPath.row)+1]?
                  var s = secPhotos[indexPath.section+1]
      
        cell.label.text = String( s![indexPath.row].ph.albumId)
        print (  s![indexPath.row].ph.albumId)

        let url = URL(string:   photos[indexPath.row].ph.thumbnailUrl)!
        cell.imageIcon.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imageIcon.sd_imageIndicator?.startAnimatingIndicator()
        cell.imageIcon.sd_setImage(with: url, placeholderImage: UIImage(named: "moon"), options: .continueInBackground,completed: nil)
   
        return cell
    }
    
    func excuteRequest()  {

        requestHandler.getPhotos(PhotoUrl,completionHandler: {
            (r)-> Void  in

            self.photos = r
            
            self.secPhotos = Dictionary(grouping: self.photos, by: \.ph.albumId)
//
//            let duplicates = crossReference
//                .filter { $1.count > 1 }
//            print(self.secPhotos.values.count)
//            print((self.secPhotos[1]?.count)!)
//            var s:SecPhotos? = nil
            
//            for (p) in self.secPhotos.enumerated(){
////                print(p.element.value.count)
//
////                for l in p.element.value{
//////                    if(l.ph.albumId == 1)
//////                    {print(l.ph)}
////                    s?.albumId = l.ph.albumId
////                    s?.photos = p.element.value
////                    self.secPhotos.append((s)!)
////                }
//            }
          
            self.collectionView.reloadData()
           
        })
      
        
        
    }
}
extension PhotosViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize(width: 400, height: 100)
        
        return CGSize(width: 150, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "photoheader", for: indexPath)as! PhotoCollectionReusableView
        var s = secPhotos[indexPath.section+1]
        header.header.text = "Photos with Album Id = "+String( s![indexPath.row].ph.albumId)
        
        
//        header.header.backgroundColor = .blue
//        header.
        return header
    }}
