//
//  AddChannelVC.swift
//  Tindwende
//
//  Created by Sawadogo Thierry on 5/16/18.
//  Copyright © 2018 Sawadogo Thierry. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    //outlets
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

        
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func createChannelBtnPressed(_ sender: Any) {
        guard let channelName = nameTxt.text, nameTxt.text != "" else { return }
        guard let channelDes = descriptionTxt.text else { return }
        
        SocketSerivce.instance.addChannel(channelName: channelName, channelDescription: channelDes) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setUpView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
