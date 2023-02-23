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
  
    func getRequest(_ url :String) async throws ->String  {
        try await AF.request(Url+url, method: .get)
            .serializingString().value

    }
}
