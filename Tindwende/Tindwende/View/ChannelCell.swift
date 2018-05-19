//
//  ChannelCell.swift
//  Tindwende
//
//  Created by Sawadogo Thierry on 5/16/18.
//  Copyright © 2018 Sawadogo Thierry. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    //outlets
    @IBOutlet weak var channelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    
    func configureCell(channel : Channel) {
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
        channelName.font = UIFont(name: "AvenirNext-Regular", size: 17)
        channelName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                channelName.font = UIFont(name: "AvenirNext-Bold", size: 22)
                channelName.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)


            }
        }
        
        
    }
    
    
    
    
    
    
    
    

}
