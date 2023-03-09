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
    //vm
//    var users:[UserClass] = []
    //vm
//    var filteredUsers:[UserClass] = []
//    var isSearching:Bool = false
    //vm
    var image:UIImage = SingeltonUser.User.image
  
    @IBOutlet weak var mapView :MKMapView!
    //vm
//    private let requestHandler =  RequestsHandler()
    //vm
    var userListViewModel = UserListViewModel()

    
    override func viewDidLoad()  {
        
//        fetchUsers()
        initViewModel()
        tableView.register(UITableViewCell.self,forCellReuseIdentifier:"cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.titleView = searchController.searchBar
        
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchResultsUpdater = self
        configureItems()
        
//        self.tabBarController?.selectedIndex = 0
        super.viewDidLoad()
        
    }
    func initViewModel(){
        userListViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        
        userListViewModel.fetchUsers()
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
        if let text = searchController.searchBar.text{
            userListViewModel.updateSearchResults(text)
//            tableView.reloadData()
        }
//vm
//        filteredUsers.removeAll()
//
//        if let text = searchController.searchBar.text{
//
//            if !(text.isEmpty)
//            {
//                filteredUsers = userListViewModel.users.filter({ $0.u.name.localizedCaseInsensitiveContains(text) })
//                isSearching = true
//            }
//            else
//            {
//                isSearching = false
//            }
//
//            tableView.reloadData()
//        }
        //vm
    }
    //vm
//    func fetchUsers(){
//
//        requestHandler.getUsers(completionHandler: {
//            (r)-> Void  in
//
//            self.users = r
//
//            self.tableView.reloadData()
//
//        })
//
//    }
    //vm
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if (!(filteredUsers.isEmpty && isSearching == true))
//        {
            let details  = self.storyboard?.instantiateViewController(identifier: "detailswithscroll") as!   CustomDetailsViewController
        details
            details.user = userListViewModel.users[indexPath.row]
//            details.user = users[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
            
//        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        
//        if (filteredUsers.isEmpty && isSearching == false)
//        {
////            return self.users.count
//            return userListViewModel.numberOfCells
//        }
//
//        else if (filteredUsers.isEmpty && isSearching == true)
//        {
//            return 1
//        }
//        else
//        {
//            return self.filteredUsers.count
//        }
        return userListViewModel.numberOfCells
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)as!
        CustomTableViewCell
        
        let cellVM = userListViewModel.getCellViewModel( at: indexPath )
       
       
        
        
        if (userListViewModel.filteredUsers.isEmpty && userListViewModel.isSearching == false)
        {
//            cell.user = users[indexPath.row]
            cell.user = cellVM.user
            cell.isHidden = false
            userNotFoundLabel.isHidden = true
            
        }
        else if (userListViewModel.filteredUsers.isEmpty && userListViewModel.isSearching == true)
        {
            
            userNotFoundLabel.isHidden = false
            userNotFoundLabel.text = "User not found !"
            cell.isHidden = true
            
        }
        else
        {
            cell.user = userListViewModel.filteredUsers[indexPath.row]
            cell.isHidden = false
            userNotFoundLabel.isHidden = true
            
        }
        
        return cell
        
    }
    
    
}



