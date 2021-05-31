//
//  VerticalCell.swift
//  Words
//
//  Created by Danil on 14/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class VerticalCell: UICollectionViewCell {
    
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
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 17)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countOfWords : UILabel = {
        let label = UILabel()
        label.text = "40 слов"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 12)
        label.textColor = UIColor.init(rgb: 0x8d8d8d)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
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
        countOfWords.text = String(data!.countOfWords) + getCorrectWords(number: data!.countOfWords)
    }
    
    private func setup() {
        backgroundColor = .white
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(header)
        header.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 5).isActive = true
        header.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3).isActive = true
        
        addSubview(countOfWords)
        countOfWords.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        countOfWords.topAnchor.constraint(equalTo: header.bottomAnchor, constant: -1).isActive = true
    }
    
}
