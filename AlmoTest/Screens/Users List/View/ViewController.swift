//
//  ViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 19/02/2023.
//

import UIKit
import Alamofire

import MapKit

class ViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource,UISearchResultsUpdating{
    
    
    @IBOutlet weak var favoriteSwitch: UISwitch!
    @IBOutlet   var tableView :UITableView!
    @IBOutlet weak var userNotFoundLabel: UILabel!
    let searchController = UISearchController()
    var image:UIImage = SingeltonUser.User.image
    @IBOutlet weak var mapView :MKMapView!
    var userListViewModel = UserListViewModel()
    
    
    override func viewDidLoad()  {
        
        
        initViewModel()
        tableView.register(UITableViewCell.self,forCellReuseIdentifier:"cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.titleView = searchController.searchBar
        
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchResultsUpdater = self
        configureItems()
        
        
        super.viewDidLoad()
        
    }
    func initViewModel(){
        userListViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        
        userListViewModel.fetchUsers()
    }
    
    func updateUserNotFoundLabel(){
        userListViewModel.updateLabel = {
            DispatchQueue.main.async { [self] in  self.userNotFoundLabel.isHidden = userListViewModel.notFoundLabelisHidden!
                self.userNotFoundLabel.text = "User not found !"
                
            }
        }
        
    }
    @IBAction func configurefavorites(){
        if favoriteSwitch.isOn
        {
            userListViewModel.users = userListViewModel.users.filter({$0.isFavorite == true})
            tableView.reloadData()
        }
        else {
            userListViewModel.users = userListViewModel.backUpUsers
            tableView.reloadData()
        }
        
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
        tableView.reloadData()
    }
    
    @objc func goToEdit(sender: UIBarButtonItem) {
        
        let editProfile  = self.storyboard?.instantiateViewController(identifier: "profile") as!   ProfileViewController
        let vc = UINavigationController(rootViewController: editProfile)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        self.searchController.searchBar.endEditing(true)
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text{
            userListViewModel.updateSearchResults(text)
            updateUserNotFoundLabel()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let details  = self.storyboard?.instantiateViewController(identifier: "detailswithscroll") as!   CustomDetailsViewController
        
        details.user = userListViewModel.users[indexPath.row]
        details.detailsViewModel.user = details.user
        details.detailsViewModel.userListViewModel = userListViewModel
        self.navigationController?.pushViewController(details, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        
        return userListViewModel.numberOfCells
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)as!
        CustomTableViewCell
        
        let cellUserInfo = userListViewModel.getUserCellInfo( at: indexPath )
        
        cell.user = cellUserInfo
        cell.favoriteIcon.isHidden = !userListViewModel.isfavorite(at: indexPath)
        return cell
        
    }
    
    
}


