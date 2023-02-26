//
//  RequestsHandler.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 20/02/2023.
//

import Foundation
import Alamofire





class RequestsHandler {

    let Url:String = "https://jsonplaceholder.typicode.com/"
    typealias tt = (String)->Void
//    func getRequest(_ url :String) async throws ->String  {
//        try await AF.request(Url+url, method: .get)
//            .serializingString().value
//
//    }
    func getRequest(_ url :String,completion :@escaping tt){
        AF.request(Url+url, method: .get)
            .responseString{
            response in
            switch response.result{
            case let .success(value):
                
                completion(value)
            case let .failure(value):
                print("hh")
          
            }
                
          
          
          
        }
//        AF.request(Url+url, method: .get).responseString {
//            response in
//            print (response.result)
//
//            completion("hi")
//        }
            
            
//            if  let error = response.error{
//                completion(nil,error)
//                print("lammma")
//            }
//            else if let jsonarray = response.value as? [User]{
//                completion(jsonarray,nil)
//                print("lammkma")
//
//            }
//            else if let jsondict = response.value as? User{
//                completion([jsondict],nil)
//                print("lama")
//            }
//
        }
        
    
    
    
    
   
}
