//
//  RequestsHandler.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 20/02/2023.
//

import Foundation
import Alamofire




class RequestsHandler  {
    
    let Url:String = "https://jsonplaceholder.typicode.com/"
    typealias usersCompletionHandler = ([UserClass])->Void
    typealias photosCompletionHandler = ([Photo])->Void
    var users:[UserClass] = []
    var photos:[Photo] = []
    var arr:[AnyObject]=[]
    
    func getUsers(_ url:String,completionHandler:@escaping usersCompletionHandler ){
        AF.request(Url+url, method: .get)
            .responseString{
                response in
                switch response.result{
                case let .success(value):
                    let decoder = JSONDecoder()
                    let jsonData = Data(value.utf8)
                    do {
                        let users: [User] = try!JSONDecoder().decode([User].self,from:jsonData)

                        for u in users {
                            let t = UserClass(u: u)

                            self.users.append(t)

                        }
                        completionHandler(self.users)

                    }
                    catch {
                        print(error.localizedDescription)
                    }
             
                    
                case let .failure(value):
                    print("failure")
                    
                
                }
                                }
        
    }
    
    func getPhotos(_ url:String,completionHandler:@escaping photosCompletionHandler){
        AF.request(Url+url, method: .get)
            .responseString{
                response in
                switch response.result{

                case let .success(value):
                    let decoder = JSONDecoder()
                    let jsonData = Data(value.utf8)
                    do {
                        let photos: [Photos] = try!JSONDecoder().decode([Photos].self,from:jsonData)

                        for ph in photos {
                            let t = Photo(ph: ph)

                            self.photos.append(t)

                        }
                        completionHandler(self.photos)

                    }
                    catch {
                        print(error.localizedDescription)
                    }


                case let .failure(value):
                    print("failure")

                }

            }
        
        
    }
    

}
