//
//  GoldCell.swift
//  Words


import UIKit

class GoldCell: UICollectionViewCell {
    
    weak var delegate : CellDelegateForSendingTest?
    let data = TestTopic.getSilverAndGoldTests()
    
    let mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.init(rgb: 0xd8d8d8).withAlphaComponent(0.7).cgColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Gold Words"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 29)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageForView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor.clear
        let image1 = TestTopic.getSilverAndGoldTests()
        iv.image = UIImage(named: image1[1].image)
        return iv
    }()
    
    let descriptionForView : UILabel = {
        let label = UILabel()
        label.text = "Подборка cамых используемых\nслов"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 12)
        label.textColor = UIColor.init(rgb: 0x8d8d8d)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let countOfWords : UILabel = {
        let label = UILabel()
        label.text = "100 слов"
        label.font = UIFont(name: "SourceSansPro-Bold", size: 12)
        label.textColor = UIColor.init(rgb: 0x8d8d8d)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Начать тест", for: .normal)
        button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 15)
        button.backgroundColor = UIColor.init(rgb: 0xE42C64)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private func setup(){
        
        addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        mainView.addSubview(header)
        header.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 26).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 54).isActive = true
        
        mainView.addSubview(descriptionForView)
        descriptionForView.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        descriptionForView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        
        mainView.addSubview(imageForView)
        imageForView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 44).isActive = true
        imageForView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        imageForView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageForView.trailingAnchor.constraint(equalTo: header.leadingAnchor, constant: -16).isActive = true
        
        mainView.addSubview(countOfWords)
        countOfWords.bottomAnchor.constraint(equalTo: imageForView.bottomAnchor).isActive = true
        countOfWords.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        
        mainView.addSubview(button)
        button.topAnchor.constraint(equalTo: imageForView.bottomAnchor, constant: 32).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction() {
        delegate?.didTapLayerButton(tap: data[1])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
