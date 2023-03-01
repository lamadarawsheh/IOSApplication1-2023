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
    let searchController = UISearchController()
    var users:[UserClass] = []
    var filteredUsers:[UserClass] = []
    var flag:Bool = false
    let UserUrl:String = "users"
    @IBOutlet weak var mapView :MKMapView!
  private let requestHandler =  RequestsHandler()
   


    override func viewDidLoad()  {
//        self.tabBarController?.tabBar.isHidden = false
        fetchUsers()
               
            tableView.register(UITableViewCell.self,forCellReuseIdentifier:"cell")

            tableView.dataSource = self
            tableView.delegate = self

        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
            super.viewDidLoad()
       

        }
  
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        filteredUsers.removeAll()
        for user in self.users {
            if(text == "") {
                flag = false
            }
            else{
                flag = true
                if(user.u.name.contains(text)){
//                if ( user.u.name.starts(with: text)){
                                    filteredUsers.append(user)
//                    print(user.u.name)
                }
            }
        }
//        print (filteredUsers.count)
        tableView.reloadData()
    }
    
    
    func fetchUsers(){
        
        requestHandler.getUsers(UserUrl,completionHandler: {
            (r)-> Void  in

            self.users = r

            self.tableView.reloadData()
            
        })
       
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             print("You tapped cell number \(indexPath.row).")
        if (filteredUsers.isEmpty && flag == true){
//            self.tabBarController?.tabBar.isHidden = false
        }
        else{
            let details  = self.storyboard?.instantiateViewController(identifier: "detailswithscroll") as!   CustomDetailsViewController
            self.navigationController?.pushViewController(details, animated: true)
            details.user = users[indexPath.row]
            
        }
         }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        if (filteredUsers.isEmpty && flag == false){
            return self.users.count
        }
        else if (filteredUsers.isEmpty && flag == true){
            return 1
        }
        else {
            return self.filteredUsers.count
        }
     
         }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)as!
        CustomTableViewCell
        
        if (filteredUsers.isEmpty && flag == false){
            cell.userNameLabel.text = users[indexPath.row].u.name
            cell.username .text = users[indexPath.row].u.username
        }
        else if (filteredUsers.isEmpty && flag == true){
            cell.userNameLabel.text = "User not found"
            cell.username .text = ""
            
            
        }
        else{
            cell.userNameLabel.text = filteredUsers[indexPath.row].u.name
            cell.username.text = filteredUsers[indexPath.row].u.username
        }
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.imageIcon.layer.borderWidth = 1.0
        cell.imageIcon.layer.masksToBounds = false
        cell.imageIcon.layer.borderColor = UIColor.blue.cgColor
        var image = UIImage(named: "profile")
        cell.imageIcon.image = image
        cell.imageIcon.layer.cornerRadius = cell.imageIcon.frame.size.width/2
      cell.imageIcon.clipsToBounds = true
        return cell

    }

   
}



