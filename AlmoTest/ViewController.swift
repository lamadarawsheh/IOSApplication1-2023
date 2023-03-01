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

            fetchUsers()
               
            tableView.register(UITableViewCell.self,forCellReuseIdentifier:"cell")

            tableView.dataSource = self
            tableView.delegate = self

            navigationItem.searchController = searchController
            searchController.searchResultsUpdater = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApperence(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            
        super.viewDidLoad()
       

        }
    
    var isExpand:Bool = false
            
    @objc func keyboardApperence(notification: NSNotification){
            if !isExpand{
                let keyboardSize:CGSize = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
                     

                     let height = min(keyboardSize.height, keyboardSize.width)
                
                    self.tableView.contentSize = CGSize(width: self.view.frame.width, height: tableView.contentSize.height + height)
                    isExpand = true
            }
        }
    @objc func keyboardDisappear(notification: NSNotification){
            if isExpand{
                let keyboardSize:CGSize = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
               

                     let height = min(keyboardSize.height, keyboardSize.width)
                    
                    self.tableView.contentSize = CGSize(width: self.view.frame.width, height: tableView.contentSize.height   - height )
                    isExpand = false
            }
            
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

                                    filteredUsers.append(user)

                    }
                }
        }

        tableView.reloadData()
    }
    
    
    func fetchUsers(){
        
        requestHandler.getUsers(completionHandler: {
            (r)-> Void  in

            self.users = r

            self.tableView.reloadData()
            
        })
       
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             print("You tapped cell number \(indexPath.row).")
        if (filteredUsers.isEmpty && flag == true){
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
            cell.nameLabel.text = users[indexPath.row].u.name
            cell.usernameLabel .text = users[indexPath.row].u.username
            cell.imageIcon.isHidden = false
            cell.userNotFoundLabel.isHidden = true
            cell.usernameLabel.isHidden = false
            cell.nameLabel.isHidden = false
            cell.accessoryType = .disclosureIndicator
        }
        else if (filteredUsers.isEmpty && flag == true){
            cell.userNotFoundLabel.isHidden = false
            cell.userNotFoundLabel.text = "User not found"
            cell.usernameLabel.isHidden = true
            cell.nameLabel.isHidden = true
            cell.imageIcon.isHidden = true
            cell.accessoryType = .none
            
        }
        else{
            cell.nameLabel.text = filteredUsers[indexPath.row].u.name
            cell.usernameLabel.text = filteredUsers[indexPath.row].u.username
            cell.imageIcon.isHidden = false
            cell.userNotFoundLabel.isHidden = true
            cell.usernameLabel.isHidden = false
            cell.nameLabel.isHidden = false
            cell.accessoryType = .disclosureIndicator
        }
        cell.selectionStyle = .none
        
        cell.imageIcon.layer.borderWidth = 1.0
        cell.imageIcon.layer.masksToBounds = false
        cell.imageIcon.layer.borderColor = UIColor.blue.cgColor
        let image = UIImage(named: "profile")
        cell.imageIcon.image = image
        cell.imageIcon.layer.cornerRadius = cell.imageIcon.frame.size.width/2
        cell.imageIcon.clipsToBounds = true
        return cell

    }

   
}



