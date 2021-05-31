//
//  SmallBannerCell.swift
//  Words

import UIKit

class SmallBannerCell: UICollectionViewCell {
    
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
        label.font = UIFont(name: "SourceSansPro-Regular", size: 14)
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
        
        if data!.author == "" {
            countOfWords.text = String(data!.countOfWords) + getCorrectWords(number: data!.countOfWords)
        } else {
            countOfWords.text = data!.author
        }
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
        iv.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        iv.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(header)
        header.topAnchor.constraint(equalTo: iv.topAnchor, constant: 3).isActive = true
        header.trailingAnchor.constraint(equalTo: iv.leadingAnchor, constant: -20).isActive = true
        header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        addSubview(countOfWords)
        countOfWords.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 2).isActive = true
        countOfWords.trailingAnchor.constraint(equalTo: header.trailingAnchor).isActive = true
        
    }
    
}
