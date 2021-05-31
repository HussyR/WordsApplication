//
//  OtherSmallCell.swift
//  Words
//
//  Created by Danil on 26/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class OtherSmallCell: MainSmallCell {
    
    let separator : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(rgb: 0xd8d8d8).withAlphaComponent(0.6)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(separator)
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 115).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
