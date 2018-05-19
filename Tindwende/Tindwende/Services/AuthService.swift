//
//  AuthService.swift
//  Tindwende
//
//  Created by Sawadogo Thierry on 5/13/18.
//  Copyright © 2018 Sawadogo Thierry. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
        
    }
    
    var authTokeN: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    
    var userEmail: String {
        
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    
    }
    
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        
        
        let body: [String: Any] = [
            "email": lowerCaseEmail, "password": password
        ]
     
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail, "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                //using SwiftJSON
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authTokeN = json["token"].stringValue
                
                self.isLoggedIn = true
                
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name ,
            "email": lowerCaseEmail ,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        
        Alamofire.request(URL_ADD_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    
    func setUserInfo (data: Data) {
        
//        do {
//            let json = try JSON(data: data)
//            let id = json["_id"].stringValue
//            let avatarColor = json["avatarColor"].stringValue
//            let avatarName = json["avatarName"].stringValue
//            let email = json["email"].stringValue
//            let name = json["name"].stringValue
//
//            UserDataSerive.instance.setUserData(id: id, avatarColor: avatarColor, avatarName: avatarName, email: email, name: name)
//
//        } catch  {
//            debugPrint(error as Any)
//        }
        
        let json = try! JSON(data: data)
        let id = json["_id"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue

        UserDataSerive.instance.setUserData(id: id, avatarColor: avatarColor, avatarName: avatarName, email: email, name: name)
        
        
        
    }



    
}
