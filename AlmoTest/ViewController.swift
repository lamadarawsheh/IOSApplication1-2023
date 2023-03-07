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
    
    
    
    @IBOutlet   var tableView :UITableView!
    
    @IBOutlet weak var userNotFoundLabel: UILabel!
    let searchController = UISearchController()
    var users:[UserClass] = []
    var filteredUsers:[UserClass] = []
    var isSearching:Bool = false
    let UserUrl:String = "users"
    var image:UIImage = SingeltonUser.User.image
    @IBOutlet weak var mapView :MKMapView!
    private let requestHandler =  RequestsHandler()
    
    
    
    override func viewDidLoad()  {
        
        fetchUsers()
        
        tableView.register(UITableViewCell.self,forCellReuseIdentifier:"cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.titleView = searchController.searchBar
        
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchResultsUpdater = self
        configureItems()
        
        self.tabBarController?.selectedIndex = 0
        super.viewDidLoad()
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        
        self.searchController.searchBar.endEditing(true)
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredUsers.removeAll()
        
        if let text = searchController.searchBar.text{
            
            if !(text.isEmpty)
            {
                filteredUsers = users.filter({ $0.u.name.localizedCaseInsensitiveContains(text) })
                isSearching = true
            }
            else
            {
                isSearching = false
            }
            
            tableView.reloadData()
        }
    }
    
    func fetchUsers(){
        
        requestHandler.getUsers(completionHandler: {
            (r)-> Void  in
            
            self.users = r
            
            self.tableView.reloadData()
            
        })
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (!(filteredUsers.isEmpty && isSearching == true))
        {
            let details  = self.storyboard?.instantiateViewController(identifier: "detailswithscroll") as!   CustomDetailsViewController
            details.user = users[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        
        if (filteredUsers.isEmpty && isSearching == false)
        {
            return self.users.count
        }
        
        else if (filteredUsers.isEmpty && isSearching == true)
        {
            return 1
        }
        else
        {
            return self.filteredUsers.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)as!
        CustomTableViewCell
        
        if (filteredUsers.isEmpty && isSearching == false)
        {
            cell.user = users[indexPath.row]
            cell.isHidden = false
            userNotFoundLabel.isHidden = true
            
        }
        else if (filteredUsers.isEmpty && isSearching == true)
        {
            
            userNotFoundLabel.isHidden = false
            userNotFoundLabel.text = "User not found !"
            cell.isHidden = true
            
        }
        else
        {
            cell.user = filteredUsers[indexPath.row]
            cell.isHidden = false
            userNotFoundLabel.isHidden = true
            
        }
        
        return cell
        
    }
    
    
}



