//
//  MessageCell.swift
//  Tindwende
//
//  Created by Sawadogo Thierry on 5/18/18.
//  Copyright © 2018 Sawadogo Thierry. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
    //outlets
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureMessageCell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataSerive.instance.returnUIColor(components: message.userAvatarColor)
        
        //pur affichez lheur des messages
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = finalDate
            //affichez lheur
        }
        
    }
    
    
    
}
