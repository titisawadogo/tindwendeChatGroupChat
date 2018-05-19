//
//  RoundedButton.swift
//  Tindwende
//
//  Created by Sawadogo Thierry on 5/14/18.
//  Copyright © 2018 Sawadogo Thierry. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
        
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }

}
