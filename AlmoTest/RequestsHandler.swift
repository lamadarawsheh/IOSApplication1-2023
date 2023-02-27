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
    func getRequest  (_ url :String,completion : @escaping usersCompletionHandler,completion2 : @escaping photosCompletionHandler){
                if (url == "users"){
        AF.request(Url+url, method: .get)
            .responseString{
                response in
                switch response.result{
                case let .success(value):
                                            let decoder = JSONDecoder()
                                            let jsonData = Data(value.utf8)
                                            do {
                                                let users: [User] = try decoder.decode([User].self, from: jsonData)
                    
                                                for user in users {
                                                    let t = UserClass(u: user)
                    
                                                    self.users.append(t)
                    
                                                }
                                                
                                                completion(self.users)
                                                completion2(self.photos)
                                            }
                    
                                            catch {
                                                print(error.localizedDescription)
                                            }
                    
                case let .failure(value):
                    print("failure")
                    
                
                }
                                }
                        }
                        else if (url == "photos")
                        {


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
                                            completion2(self.photos)

                                        }
                                        catch {
                                            print(error.localizedDescription)
                                        }


                                    case let .failure(value):
                                        print("failure")

                                    }

                                }
//
//
//
//                        }
//                        AF.request(Url+url, method: .get).responseString {
//                            response in
//                            print (response.result)
//
//                            completion("hi")
//                        }
//
//
//                            if  let error = response.error{
//                                completion(nil,error)
//                                print("lammma")
//                            }
//                            else if let jsonarray = response.value as? [User]{
//                                completion(jsonarray,nil)
//                                print("lammkma")
//
//                            }
//                            else if let jsondict = response.value as? User{
//                                completion([jsondict],nil)
//                                print("lama")
//                            }
//
//
//
//
                
                
                
                
            }
    }
}
