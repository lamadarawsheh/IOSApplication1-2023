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
  
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        filteredUsers.removeAll()
        for user in self.users {
            if(text == "") {
            }
            else{
                if ( user.u.name.starts(with: text)){
                                    filteredUsers.append(user)
                    print(user.u.name)
                }
            }
        }
        print (filteredUsers.count)
        tableView.reloadData()
    }
    
    
    func fetchUsers(){
        
        requestHandler.getRequest(UserUrl,completion: {
            (r)-> Void  in

//
//            let decoder = JSONDecoder()
//            let jsonData = Data(r.utf8)
//            do {
//                let users: [User] = try decoder.decode([User].self, from: jsonData)
//
//                for user in users {
//                        let t = UserClass(u: user)
//
//                    self.users.append(t)
//
//                       }
//                self.tableView.reloadData()
//            } catch {
//                print(error.localizedDescription)
//            }
            
            self.users = r

            self.tableView.reloadData()
           
        },completion2: {(m)->Void in print ("")})
       
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             print("You tapped cell number \(indexPath.row).")
       

       let details  = self.storyboard?.instantiateViewController(identifier: "detailswithscroll") as!   CustomDetailsViewController

                             self.navigationController?.pushViewController(details, animated: true)
        details.user = users[indexPath.row]

         }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        if (filteredUsers.isEmpty){
            return self.users.count
        }
        else {
            return self.filteredUsers.count
        }
     
         }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CustomTableViewCell
//
//        cell.userNameLabel.text = users[indexPath.row].u.name
//
//           return cell
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)as!
        CustomTableViewCell
        
        if (filteredUsers.isEmpty){
            cell.userNameLabel.text = users[indexPath.row].u.name
        }
        else{
            cell.userNameLabel.text = filteredUsers[indexPath.row].u.name
        }
        
        cell.accessoryType = .disclosureIndicator
        
//        cell.selectionStyle =
       
        //          let image = UIImage(named: "Arrow.png")
//          let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!));
//          checkmark.image = image
//        cell.accessoryView =

        
//        cell.accessoryType = disclosureIndicator()
        return cell

    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//           return 1
//       }
       
       // Set the spacing between sections
     
    
   
}



