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
    let UsersUrl:String = "users"
    let PhotosUrl:String = "photos"
    typealias usersCompletionHandler = (Bool,[UserClass])->Void
    typealias photosCompletionHandler = (Bool,[Photo])->Void
    var users:[UserClass] = []
    var photos:[Photo] = []
    var arr:[AnyObject]=[]
    
    func getUsers(completionHandler:@escaping usersCompletionHandler ){
        AF.request(Url+UsersUrl, method: .get)
            .responseString{
                response in
                switch response.result{
                case let .success(value):
                    
                    let jsonData = Data(value.utf8)
                    do {
                        let users: [User] = try JSONDecoder().decode([User].self,from:jsonData)
                        
                        for u in users {
                            let t = UserClass(u: u)
                            
                            self.users.append(t)
                            
                        }
                        
                        completionHandler(true,self.users)
                        
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                    
                    
                    
                    
                case .failure(_):
                    print("failure")
                    completionHandler(false,self.users)
                }
            }
        
    }
    
    func getPhotos(completionHandler:@escaping photosCompletionHandler){
        AF.request(Url+PhotosUrl, method: .get)
            .responseString{
                response in
                switch response.result{
                    
                case let .success(value):
                    
                    let jsonData = Data(value.utf8)
                    do {
                        let photos: [Photos] = try JSONDecoder().decode([Photos].self,from:jsonData)
                        
                        for ph in photos {
                            let t = Photo(ph: ph)
                            
                            self.photos.append(t)
                            
                        }
                        completionHandler(true,self.photos)
                        
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                    
                    
                case .failure(_):
                    print("failure")
                    completionHandler(false,self.photos)
                    
                }
                
            }
        
        
    }
    
    
}
