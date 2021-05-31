//
//  VerbsBannerCell.swift
//  Words
//
//  Created by Danil on 29/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class VerbsBannerCell: UICollectionViewCell {
    
    var data : TestTopic?
    
    let iv : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.font = UIFont(name: "SourceSansPro-Bold", size: 22)
        label.textColor = UIColor(white: 1, alpha: 1)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true;
        label.minimumScaleFactor = 0.5 ;
        return label
    }()
    
    let countOfWords : UILabel = {
        let label = UILabel()
        label.text = "40 слов"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 12)
        label.textColor = UIColor(white: 1, alpha: 1)
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
        iv.image = UIImage(named: data!.image)
        header.text = data!.header
        countOfWords.text = String(data!.countOfWords) + getCorrectWords(number: data!.countOfWords)
    }
    
    let gradient = CAGradientLayer()
    
    private func setup() {
        backgroundColor = .white
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 7
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.cornerRadius = 10
        
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        gradient.cornerRadius = 10
        layer.addSublayer(gradient)
        
        addSubview(iv)
        iv.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 70).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        addSubview(header)
        header.topAnchor.constraint(equalTo: iv.topAnchor, constant: 12).isActive = true
        header.leadingAnchor.constraint(equalTo: iv.trailingAnchor, constant: 20).isActive = true
        
        addSubview(countOfWords)
        countOfWords.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 1).isActive = true
        countOfWords.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        
    }
    
}
