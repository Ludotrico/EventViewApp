//
//  Authorization.swift
//  EventView
//
//  Created by Ludovico Veniani on 1/20/21.
//

import Foundation
import Alamofire


//response.response?.statusCode
class AuthAPI {
        
    static func signUpUser(completion: @escaping(Result<Int, Error>) -> ()) {
        var paramaters: [String: Any] = [:]
        paramaters["username"] = UserDefaults.standard.string(forKey: "username")!
        paramaters["password"] = UserDefaults.standard.string(forKey: "password")!
        

        
        DispatchQueue.global(qos: .userInitiated).async {
            AF.request("\(domain)/signup", method: .post, parameters: paramaters, encoding: JSONEncoding.default)
                .response { (response) in
                    if response.error == nil {
                        completion(.success(response.response!.statusCode))
                        
                    } else {
                        completion(.failure(response.error!))
                    }
                    
            }
        }
    }
    
    static func loginUser(completion: @escaping(Result<Int, Error>) -> ()) {
        var paramaters: [String: Any] = [:]
        paramaters["username"] = UserDefaults.standard.string(forKey: "username")
        paramaters["password"] = UserDefaults.standard.string(forKey: "password")


        
        DispatchQueue.global(qos: .userInitiated).async {
            AF.request("\(domain)/login", method: .post, parameters: paramaters, encoding: JSONEncoding.default)
                .response { (response) in
                    if response.error == nil {
                        completion(.success(response.response!.statusCode))
                    } else {
                        completion(.failure(response.error!))
                    }
                    
            }
        }
    }
    
    
}
