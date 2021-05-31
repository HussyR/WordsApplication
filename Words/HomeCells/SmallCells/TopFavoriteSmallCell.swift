//
//  TopFavoriteSmallCell.swift
//  Words
//
//  Created by Danil on 15/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class TopFavoriteSmallCell: UICollectionViewCell {
    
    var data : TestTopic?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 13)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData() {
        imageView.image = UIImage(named: data!.image)
        header.text = data!.header
    }
    
    private func setup() {
        backgroundColor = .white
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        addSubview(header)
        header.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        header.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        
    }
}
