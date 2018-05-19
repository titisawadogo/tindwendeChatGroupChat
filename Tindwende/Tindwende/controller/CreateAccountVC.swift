//
//  CreateAccountVC.swift
//  Tindwende
//
//  Created by Sawadogo Thierry on 5/13/18.
//  Copyright © 2018 Sawadogo Thierry. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController, UITextFieldDelegate {
    
    //outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //code mi pur cache keyboard
        self.emailTxt.delegate = self
        self.passTxt.delegate = self
        self.usernameTxt.delegate = self
        setUpView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataSerive.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataSerive.instance.avatarName)
            avatarName = UserDataSerive.instance.avatarName
        }
    }
    
    //now vrai code pour cache keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //code kan tu appui sur return sa disparai oci
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTxt.resignFirstResponder()
        passTxt.resignFirstResponder()
        usernameTxt.resignFirstResponder()
        return (true)
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let name = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                
                                self.performSegue(withIdentifier: UNWINND, sender: nil)
                                
                                NotificationCenter.default.post(name: NOTIF_USERDATA_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
        
    }
    
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.3) {
            self.userImage.backgroundColor = self.bgColor
        }
        
    }
    

    @IBAction func close2Pressed(_ sender: Any) {
       performSegue(withIdentifier: UNWINND, sender: nil)
    }
    
    func setUpView() {
        spinner.isHidden = true
    }
    

}






