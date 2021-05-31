//
//  LettersCell.swift
//  Words
//
//  Created by Danil on 18/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class LettersCell: UICollectionViewCell {
    
    var indexPath : Int = 0
    var word : Word?
    var isLoad = false
    weak var testDelegate : TestDelegate?
    let speaker = TalkingService()
    
    var smallButtons = [UIButton]()
    
    let viewForSmallButtons : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let makeFavoriteImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        return image
    }()
    
    let mainWord : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "word"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 30)
        return label
    }()
    
    let voiceImage : UIImageView = {
        
        let image = UIImageView(image: UIImage(named: "Sound"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        
        return image
    }()
    
    let buttonNext : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Пропустить", for: .normal)
        button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainBlue()
        return button
    }()
    
    let viewUnderMainWord : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 7
        return view
    }()
    
    let viewUnderTranslateWord : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainBlue()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 7
        return view
    }()
    
    let translateWord : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Переведи слово"
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.font = UIFont(name: "SourceSansPro-Bold", size: 26)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        setup()
        setupMainUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
    }
    
    public func deleteOldUI() {
        if isLoad {
            for _ in 0..<word!.word.count {
                smallButtons[0].removeFromSuperview()
                smallButtons.remove(at: 0)
            }
            viewForSmallButtons.removeConstraints(viewForSmallButtons.constraints)
            viewForSmallButtons.removeFromSuperview()
        }
        currentWordIndex = 0
        translateWord.text = "Переведи слово"
    }
    
    @objc func skipAction() {
        testDelegate?.didTapButton(tap: .skip, indexPath: indexPath)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if touch.view == voiceImage {
            speaker.say(word!.word)
        }
    }
    
    public func setupNeededWord(indexPath : Int) {
        self.indexPath = indexPath
        mainWord.text = word!.translate
        for _ in word!.word {
            let button = UIButton()
            button.setTitleColor(.init(rgb: 0x979797), for: .normal)
            button.backgroundColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
            button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 24)
            button.layer.cornerRadius = 5
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.layer.shadowRadius = 4
            button.layer.shadowOpacity = 0.1
            smallButtons.append(button)
        }
        let y = word!.word.count
        let string = word!.word.shuffled()
        for i in 0..<y {
            let index = string.index(string.startIndex, offsetBy: i)
            let title = String(string[index])
            smallButtons[(i + indexPath) % y].setTitle(title, for: .normal)
        }
        
        setupOtherUI()
        if !isLoad  {
            
            isLoad = true
        }
    }
    
    var currentWordIndex = 0
    
    
    @objc func tapButton (button : UIButton) {
        translateWord.textColor = UIColor.white
        if button.backgroundColor == .mainBlue() {
            return
        }
        
        let character = button.currentTitle!
        let string = word!.word
        let index = string.index(string.startIndex, offsetBy: currentWordIndex)
        let index2 = string.index(string.endIndex, offsetBy: -1)
        
        if translateWord.text == "Переведи слово" {
            translateWord.text = ""
        }
        
        if character == String(string[index]) {
            
            print("OK")
            currentWordIndex += 1
            translateWord.text = translateWord.text! + String(string[index])
            button.backgroundColor = .mainBlue()
            button.setTitleColor(.white, for: .normal)
            if character == String(string[index2]) && translateWord.text!.count == word!.word.count {
                    self.testDelegate?.didTapButton(tap: .skip, indexPath: self.indexPath)
            }
            
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                button.backgroundColor = UIColor.init(rgb: 0xE42C64)
                button.setTitleColor(.white, for: .normal)
            }) { (true) in
                UIView.animate(withDuration: 0.25, animations: {
                    button.backgroundColor = .white
                    button.setTitleColor(.init(rgb: 0x979797), for: .normal)
                })
            }
        }
        
        
        print("Нажали")
        
    }
    
    private func setupMainUI() {
        
        buttonNext.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        
        addSubview(viewUnderMainWord)
        viewUnderMainWord.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewUnderMainWord.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        viewUnderMainWord.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        viewUnderMainWord.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        viewUnderMainWord.addSubview(voiceImage)
        voiceImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        voiceImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        voiceImage.heightAnchor.constraint(equalToConstant: 26).isActive = true
        voiceImage.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        viewUnderMainWord.addSubview(mainWord)
        mainWord.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        mainWord.bottomAnchor.constraint(equalTo: viewUnderMainWord.bottomAnchor, constant: -20).isActive = true
        
        addSubview(buttonNext)
        buttonNext.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        buttonNext.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        buttonNext.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        buttonNext.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(viewUnderTranslateWord)
        viewUnderTranslateWord.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        viewUnderTranslateWord.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        viewUnderTranslateWord.topAnchor.constraint(equalTo: viewUnderMainWord.bottomAnchor, constant: 20).isActive = true
        viewUnderTranslateWord.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        viewUnderTranslateWord.addSubview(translateWord)
        translateWord.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        translateWord.topAnchor.constraint(equalTo: viewUnderTranslateWord.topAnchor, constant: 20).isActive = true
    }
    
    private func setupOtherUI() {
        
        
        addSubview(viewForSmallButtons)
        let widthView = smallButtons.count * 50 + (smallButtons.count - 1) * 10
        //let floors = widthView / 340
        let floors = (widthView <= 350 ? 1 : 2)
        let height = floors * 60 + (floors - 1) * 10
        
        print(widthView)
        print(height)
        
        viewForSmallButtons.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        viewForSmallButtons.widthAnchor.constraint(equalToConstant: CGFloat((widthView <= 350 ? widthView : 350))).isActive = true
        viewForSmallButtons.topAnchor.constraint(equalTo: viewUnderTranslateWord.bottomAnchor, constant: 30).isActive = true
        viewForSmallButtons.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        for i in 0..<smallButtons.count {
            
            viewForSmallButtons.addSubview(smallButtons[i])
            smallButtons[i].heightAnchor.constraint(equalToConstant: 60).isActive = true
            smallButtons[i].widthAnchor.constraint(equalToConstant: 50).isActive = true
            if i > 5 {
                if i % 6 == 0 {
                    smallButtons[i].leadingAnchor.constraint(equalTo: viewForSmallButtons.leadingAnchor).isActive = true
                    smallButtons[i].topAnchor.constraint(equalTo: smallButtons[0].bottomAnchor, constant: 10).isActive = true
                }
                else {
                    smallButtons[i].leadingAnchor.constraint(equalTo: smallButtons[i - 1].trailingAnchor, constant: 10).isActive = true
                    smallButtons[i].topAnchor.constraint(equalTo: smallButtons[0].bottomAnchor, constant: 10).isActive = true
                }
            } else {
                if i == 0 {
                    smallButtons[i].leadingAnchor.constraint(equalTo: viewForSmallButtons.leadingAnchor).isActive = true
                    smallButtons[i].topAnchor.constraint(equalTo: viewForSmallButtons.topAnchor).isActive = true
                } else {
                    smallButtons[i].leadingAnchor.constraint(equalTo: smallButtons[i - 1].trailingAnchor, constant: 10).isActive = true
                    smallButtons[i].topAnchor.constraint(equalTo: viewForSmallButtons.topAnchor).isActive = true
                }
            }
        }
        
    }
}
