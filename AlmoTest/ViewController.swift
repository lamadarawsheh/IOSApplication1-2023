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
    @IBOutlet weak var mapView :MKMapView!
    private let requestHandler =  RequestsHandler()
   


    override func viewDidLoad()  {

            fetchUsers()
               
            tableView.register(UITableViewCell.self,forCellReuseIdentifier:"cell")

            tableView.dataSource = self
            tableView.delegate = self

            navigationItem.searchController = searchController
            searchController.searchResultsUpdater = self

            super.viewDidLoad()
       

        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
            self.searchController.searchBar.endEditing(true)
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredUsers.removeAll()
        
        if let text = searchController.searchBar.text{
            
            if !(text == "")
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
                self.navigationController?.pushViewController(details, animated: true)
                details.user = users[indexPath.row]
            
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



