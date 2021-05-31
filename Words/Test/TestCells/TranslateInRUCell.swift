//
//  TranslateInRUCell.swift
//  Words

import UIKit

class TranslateInRUCell: UICollectionViewCell {
    
    
    var indexPath : Int = 0
    var isLoad = false
    var word : Word?
    weak var testDelegate : TestDelegate?
    weak var speakDelegate : SayDelegate?
    let speaker = TalkingService()
    
    let answerButtons : [UIButton] = {
        var buttons = [UIButton]()
        
        for i in 1...4 {
            let button = UIButton()
            button.setTitle("ответ №\(i)", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular", size: 22)
            button.layer.cornerRadius = 5
            button.layer.shadowRadius = 6
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.layer.shadowOpacity = 0.10
            buttons.append(button)
        }
        
        return buttons
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
        label.text = "Выбери перевод"
        label.font = UIFont(name: "SourceSansPro-Bold", size: 26)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
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
    
    @objc func skipAction() {
        testDelegate?.didTapButton(tap: .skip, indexPath : indexPath)
    }
    
    public func setupNeededWord(indexPath : Int) {
        repairUI()
        self.indexPath = indexPath
        mainWord.text = word!.word
        
        let y = indexPath
        
        answerButtons[y % 4].setTitle(word!.translate, for: .normal)
        answerButtons[(y+1) % 4].setTitle(word!.tranRU1, for: .normal)
        answerButtons[(y+2) % 4].setTitle(word!.tranRU2, for: .normal)
        answerButtons[(y+3) % 4].setTitle(word!.tranRU3, for: .normal)
        
        if word != nil && isLoad == false {
            setupOtherUI()
            isLoad = true
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if touch.view == voiceImage {
            speaker.say(word!.word)
        }
    }
    
    private func repairUI() {
        for i in 0...3 {
            answerButtons[i].backgroundColor = .white
            answerButtons[i].setTitleColor(.black, for: .normal)
        }
    }
    
    @objc func tapTrueAnswer (button : UIButton) {
        
        speaker.say(word!.word)
        
        print("Нажали")
        if button.currentTitle == word!.translate{
            print("Правильно")
            UIView.animate(withDuration: 1, animations: {
                button.backgroundColor = .mainBlue()
                button.setTitleColor(.white, for: .normal)
            }) { (true) in
                self.testDelegate?.didTapButton(tap: .skip, indexPath: self.indexPath)
            }
        } else {
            
            var index = 0
            
            for i in 0...3 {
                if answerButtons[i].currentTitle == word?.translate {
                    index = i
                }
            }
            let button2 = answerButtons[index]
            
            print("неправильно")
            UIView.animate(withDuration: 1, animations: {
                button.backgroundColor = UIColor.init(rgb: 0xE42C64)
                button.setTitleColor(.white, for: .normal)
                button2.backgroundColor = .mainBlue()
                button2.setTitleColor(.white, for: .normal)
            }) { (true) in
                self.testDelegate?.didTapButton(tap: .skip, indexPath: self.indexPath)
            }
        }
    }
    
    private func setupMainUI() {
        
        for i in 0...3 {
            answerButtons[i].addTarget(self, action: #selector(tapTrueAnswer), for: .touchUpInside)
        }
        
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
        for i in 0...3 {
            
            let height2 = bounds.height - 160 - 90 - 60 - 20
            let sizeForCell = (height2 - 75) / 4
            
            addSubview(answerButtons[i])
            answerButtons[i].heightAnchor.constraint(equalToConstant: sizeForCell).isActive = true
            answerButtons[i].leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
            answerButtons[i].trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        }
        
        answerButtons[0].bottomAnchor.constraint(equalTo: buttonNext.topAnchor, constant: -15).isActive = true
        answerButtons[1].bottomAnchor.constraint(equalTo: answerButtons[0].topAnchor, constant: -15).isActive = true
        answerButtons[2].bottomAnchor.constraint(equalTo: answerButtons[1].topAnchor, constant: -15).isActive = true
        answerButtons[3].bottomAnchor.constraint(equalTo: answerButtons[2].topAnchor, constant: -15).isActive = true
        
    }
}
