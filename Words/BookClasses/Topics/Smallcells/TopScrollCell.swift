//
//  TopScrollCell.swift
//  Words


import UIKit

class TopScrollCell: UICollectionViewCell {
    
    var data : TestTopic?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Продукты"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 30)
        label.textColor = UIColor(white: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true;
        label.minimumScaleFactor = 0.5 ;
        return label
    }()
    
    let countOfWords : UILabel = {
        let label = UILabel()
        label.text = "40 слов"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let gradient : CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.locations = [0.0, 0.33, 0.66, 1]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        return gradient
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public func setupData() {
        imageView.image = UIImage(named: data!.image)
        header.text = data!.header
        countOfWords.text = String(data!.countOfWords) + getCorrectWords(number: data!.countOfWords)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupGradient(color1 : UIColor, color2 : UIColor) {
        gradient.colors = [color1.cgColor, color2.cgColor, color2.cgColor, color1.cgColor]
    }
    
    private func setup() {
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        layer.addSublayer(gradient)
        
        backgroundColor = .black
        addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
        
        addSubview(header)
        header.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 24).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 52).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        addSubview(countOfWords)
        countOfWords.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 24).isActive = true
        countOfWords.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8).isActive = true
    }
    
}
