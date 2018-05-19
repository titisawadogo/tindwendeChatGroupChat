//
//  ProfileVC.swift
//  Tindwende
//
//  Created by Sawadogo Thierry on 5/15/18.
//  Copyright © 2018 Sawadogo Thierry. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    //outlets
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpView()
    }

    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataSerive.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USERDATA_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    func setUpView() {
        
        userName.text = UserDataSerive.instance.name
        userEmail.text = UserDataSerive.instance.email
        profileImage.image = UIImage(named: UserDataSerive.instance.avatarName)
        profileImage.backgroundColor = UserDataSerive.instance.returnUIColor(components: UserDataSerive.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
