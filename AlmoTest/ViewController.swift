//
//  ViewController.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 19/02/2023.
//

import UIKit
import Alamofire



class ViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
   
    @IBOutlet   var tableView :UITableView!
    var names:[UserO] = []
    let UserUrl:String = "users"
  
    override func viewDidLoad()  {

        
        Task {
                        try await excuteRequest()
                    }
                
        
            tableView.register(UITableViewCell.self,forCellReuseIdentifier:"cell")
    
            tableView.dataSource = self
            tableView.delegate = self
            
            
            
            super.viewDidLoad()
           
        }
    func excuteRequest() async throws {
        let r = RequestsHandler()
        
        async let getValue = r.getRequest(UserUrl)

        let responses = try await (getValue)

                        let json = responses.data(using: .utf8)!
                        let users: [User] = try!JSONDecoder().decode([User].self,from:json)

        for user in users {
            let t = UserO(u: user)
         
            names.append(t)
        }
       
        self.tableView.reloadData()

      
    }
    


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             print("You tapped cell number \(indexPath.row).")
       

       let details  = self.storyboard?.instantiateViewController(identifier: "details") as!   DetailsViewController

                             self.navigationController?.pushViewController(details, animated: true)
        details.user = names[indexPath.row]
//        details.name = names[indexPath.row].u.username
//        details.email = names[indexPath.row].u.email
//        details.phone = names[indexPath.row].u.phone
//        details.address = names[indexPath.row].u.address.city + "-" + names[indexPath.row].u.address.street + "-" + names[indexPath.row].u.address.suite + "-" + names[indexPath.row].u.address.zipcode
         }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return self.names.count
         }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row].u.name
//        cell.imageViewIcon.image = UIImage(named: "moon" )
         
           return cell
    }


}



