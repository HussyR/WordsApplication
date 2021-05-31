//
//  ProfileCell.swift
//  Words
//
//  Created by Danil on 15/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    weak var delegate : CellDelegate?
    var image = UIImage(named: "")  {
        didSet {
            avatar.image  = image
        }
    }
    
    let separateLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(rgb: 0xd8d8d8).withAlphaComponent(0.6)
        return view
    }()
    
    let mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let nickName : UILabel = {
        let label = UILabel()
        label.text = "NickName"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 27)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let avatar: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor.init(white: 0, alpha: 1)
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let rank : UILabel = {
        let label = UILabel()
        label.text = "Начинающий"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 12)
        label.textColor = UIColor.init(rgb: 0x8d8d8d)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let firstImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "smallStar")
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    let secondImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "smallStar")
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    
    let wordslabel1 : UILabel = {
        let label = UILabel()
        label.text = "Words"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 12)
        label.textColor = UIColor.init(rgb: 0x8d8d8d)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    let countOfWords1 : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 15)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let wordslabel2 : UILabel = {
        let label = UILabel()
        label.text = "Verbs"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 12)
        label.textColor = UIColor.init(rgb: 0x8d8d8d)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    let countOfWords2 : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 15)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if touch.view == avatar {
            delegate?.didTapLayerButton(tap: "image")
        }
    }
    
    public func getRank() {
        switch Double(learnWords) {
        case 0..<UserLevels.student:
            rank.text = "Начинающий"
        case UserLevels.student..<UserLevels.znatok:
            rank.text = "Студент"
        case UserLevels.znatok..<UserLevels.master:
            rank.text = "Знаток"
        case UserLevels.master..<UserLevels.professionsal:
            rank.text = "Мастер"
        case UserLevels.professionsal..<UserLevels.native:
            rank.text = "Профессионал"
        case UserLevels.native...100000:
            rank.text = "Носитель"
        default:
            break
        }
    }
    
    private func setup(){
        getRank()
        let image2 = defaults.value(forKey: KeysForDefaults.avatarData) as! Data
        image = UIImage(data: image2)
        
        addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        mainView.addSubview(avatar)
        avatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        avatar.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 120).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        mainView.addSubview(nickName)
        nickName.topAnchor.constraint(equalTo: topAnchor, constant: 29).isActive = true
        nickName.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 24).isActive = true
        
        mainView.addSubview(rank)
        rank.leadingAnchor.constraint(equalTo: nickName.leadingAnchor).isActive = true
        rank.topAnchor.constraint(equalTo: nickName.bottomAnchor).isActive = true
        
        mainView.addSubview(firstImage)
        firstImage.topAnchor.constraint(equalTo: rank.bottomAnchor, constant: 36).isActive = true
        firstImage.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 24).isActive = true
        firstImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        firstImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        mainView.addSubview(secondImage)
        secondImage.topAnchor.constraint(equalTo: firstImage.topAnchor).isActive = true
        secondImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        secondImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        secondImage.leadingAnchor.constraint(equalTo: firstImage.trailingAnchor, constant: 76).isActive = true
        
        mainView.addSubview(wordslabel1)
        wordslabel1.leadingAnchor.constraint(equalTo: firstImage.trailingAnchor, constant: 10).isActive = true
        wordslabel1.topAnchor.constraint(equalTo: firstImage.topAnchor, constant: -2).isActive = true
        
        mainView.addSubview(countOfWords1)
        countOfWords1.leadingAnchor.constraint(equalTo: wordslabel1.leadingAnchor).isActive = true
        countOfWords1.topAnchor.constraint(equalTo: wordslabel1.bottomAnchor).isActive = true
        
        mainView.addSubview(wordslabel2)
        wordslabel2.leadingAnchor.constraint(equalTo: secondImage.trailingAnchor, constant: 10).isActive = true
        wordslabel2.topAnchor.constraint(equalTo: secondImage.topAnchor, constant: -2).isActive = true
        
        mainView.addSubview(countOfWords2)
        countOfWords2.leadingAnchor.constraint(equalTo: wordslabel2.leadingAnchor).isActive = true
        countOfWords2.topAnchor.constraint(equalTo: wordslabel2.bottomAnchor).isActive = true
        
        mainView.addSubview(separateLine)
        separateLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separateLine.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        separateLine.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        separateLine.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        nickName.text = userName
        countOfWords1.text = String(learnWords)
        countOfWords2.text = String(verbs)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
