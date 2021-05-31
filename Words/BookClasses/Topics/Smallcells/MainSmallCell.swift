//
//  MainSmallCell.swift
//  Words


import UIKit

class MainSmallCell: UICollectionViewCell {
    
    var data : TestTopic?
    
    let iv : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 22)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countOfWords : UILabel = {
        let label = UILabel()
        label.text = "40 слов"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 15)
        label.textColor = UIColor.init(rgb: 0x8d8d8d)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    private func setup() {
        
        addSubview(iv)
        iv.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        iv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 70).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        addSubview(header)
        header.leadingAnchor.constraint(equalTo: iv.trailingAnchor, constant: 20).isActive = true
        header.topAnchor.constraint(equalTo: iv.topAnchor, constant: 7).isActive = true
        
        addSubview(countOfWords)
        countOfWords.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        countOfWords.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 3).isActive = true
        
    }
    
}
