//
//  LoginVC.swift
//  Tindwende
//
//  Created by Sawadogo Thierry on 5/12/18.
//  Copyright © 2018 Sawadogo Thierry. All rights reserved.
//

import UIKit

class LoginVC: UIViewController , UITextFieldDelegate{
    
    //outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true

        
    }
    
    //pour enleve keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        guard let email = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USERDATA_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
        
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    
    
    
    
    
    
    
    
}
