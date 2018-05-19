//
//  UserDataService.swift
//  Tindwende
//
//  Created by Sawadogo Thierry on 5/14/18.
//  Copyright © 2018 Sawadogo Thierry. All rights reserved.
//

import Foundation


class UserDataSerive {
    
    static let instance = UserDataSerive()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    //tt sa pour k l user garde les couleur kil avai choisit
    func returnUIColor(components: String) -> UIColor {
        
        
        let scanner = Scanner(string: components)
        let Skipped = CharacterSet(charactersIn: "[], ")
        let comma  = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = Skipped
        
        var r, g, b, a : NSString?
        
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
    }
    
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authTokeN = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
        
    }
    
    
    
    
}
