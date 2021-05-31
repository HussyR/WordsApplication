//
//  TopWatchCell.swift
//  Words
//
//  Created by Danil on 16/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class TopWatchCell: UICollectionViewCell {
    
    weak var delegate : CellDelegate?
    
    var test : TestTopic?
    
    let mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    public func setupData() {
        header.text = test!.header
        imageForView.image = UIImage(named: test!.watchImage)
        if test!.header == "Глаголы" || test!.header == "Существительные" || test!.header == "Прилагательные" || test!.header == "Silver Words" {
            countOfWords.text = "10 слов"
            return
        }
        countOfWords.text = String(test!.countOfWords) + getCorrectWords(number: test!.countOfWords)
        
        if test!.author == "" {
            authorLabel.alpha = 0
        } else {
            authorLabel.alpha = 1
            authorLabel.text = test!.author
            let attributedString = NSMutableAttributedString(string: test!.author)
            attributedString.addAttribute(.font, value: UIFont(name: "SourceSansPro-SemiBold", size: 15), range: NSRange(location: 0, length: test!.author.count))
            if test!.author == "EngLine" {
                attributedString.addAttribute(.link, value: "https://vk.com/english_language_learn", range: NSRange(location: 0, length: test!.author.count))
            } else {
                attributedString.addAttribute(.link, value: "https://vk.com/eng_5", range: NSRange(location: 0, length: test!.author.count))
            }
            
            
            
            authorLabel.attributedText = attributedString
        }
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Тема"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 22)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true;
        return label
    }()
    
    let imageForView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor.clear
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let countOfWords : UILabel = {
        let label = UILabel()
        label.text = "100 слов"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 15)
        label.textColor = UIColor.init(rgb: 0x8d8d8d)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let authorLabel : UITextView = {
        let label = UITextView()
        label.text = "Автор"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 22)
        label.textColor = UIColor.init(rgb: 0x8d8d8d)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        label.isEditable = false
        
        return label
    }()
    
    let button : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Начать тест", for: .normal)
        button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 15)
        button.backgroundColor = UIColor.mainBlue()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    let separateView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(rgb: 0xD8D8D8).withAlphaComponent(0.6)
        return view
    }()
    let separateView2 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(rgb: 0xD8D8D8).withAlphaComponent(0.6)
        return view
    }()
    
    private func setup(){
        
        button.addTarget(self, action: #selector(setupButton), for: .touchUpInside)
        
        addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        mainView.addSubview(imageForView)
        imageForView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 24).isActive = true
        imageForView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageForView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageForView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24).isActive = true
        
        mainView.addSubview(header)
        header.leadingAnchor.constraint(equalTo: imageForView.trailingAnchor, constant: 20).isActive = true
        header.topAnchor.constraint(equalTo: imageForView.topAnchor, constant: 14).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        mainView.addSubview(countOfWords)
        countOfWords.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 3).isActive = true
        countOfWords.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        
        mainView.addSubview(authorLabel)
        authorLabel.leadingAnchor.constraint(equalTo: imageForView.trailingAnchor, constant: 14).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: imageForView.bottomAnchor, constant: 0).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        mainView.addSubview(separateView)
        separateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        separateView.topAnchor.constraint(equalTo: imageForView.bottomAnchor, constant: 16).isActive = true
        separateView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        separateView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        mainView.addSubview(button)
        button.topAnchor.constraint(equalTo: separateView.bottomAnchor, constant: 16).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60).isActive = true
        
        mainView.addSubview(separateView2)
        separateView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        separateView2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        separateView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        separateView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    @objc private func setupButton() {
        
        if test!.header == "Глаголы" || test!.header == "Существительные" || test!.header == "Прилагательные" || test!.header == "Silver Words" {
            delegate?.didTapLayerButton(tap: "inf")
            return
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.button.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }) { (true) in
            
            UIView.animate(withDuration: 0.1, animations: {
                self.button.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            })
        }
        self.button.setTitle("Выберите слово", for: .normal)
        self.delegate?.didTapLayerButton(tap: "tapButton")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
