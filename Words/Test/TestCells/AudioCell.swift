//
//  AudioCell.swift
//  Words


import UIKit

class AudioCell: UICollectionViewCell {
    
    var indexPath : Int = 0
    var isLoad = false
    var word : Word?
    weak var testDelegate : TestDelegate?
    let speaker = TalkingService()
    
    let bigVoice : UIImageView = {
        let image = UIImageView(image: UIImage(named: "BigSound"))
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
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
        label.text = "Послушай и выбери перевод"
        label.font = UIFont(name: "SourceSansPro-Bold", size: 22)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        return label
    }()
    
    let answerButtons : [UIButton] = {
        var buttons = [UIButton]()
        
        for i in 1...4 {
            let button = UIButton()
            button.setTitle("ответ №\(i)", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular", size: 22)
            button.backgroundColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 5
            button.layer.shadowRadius = 6
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.layer.shadowOpacity = 0.10
            buttons.append(button)
        }
        
        return buttons
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        
        setupMainUI()
        setup()
        print(bigVoice.frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
    }
    
    @objc func skipAction() {
        testDelegate?.didTapButton(tap: .skip, indexPath: indexPath)
    }
    
    public func setupNeededWord(indexPath : Int) {
        repairUI()
        self.indexPath = indexPath
        
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
    
    public func sayWord () {
        speaker.say(word!.word)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if touch.view == bigVoice {
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
        if button.currentTitle == word!.translate{
            print("Правильно")
            UIView.animate(withDuration: 0.5, animations: {
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
            UIView.animate(withDuration: 0.5, animations: {
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
        
        viewUnderMainWord.addSubview(bigVoice)
        bigVoice.heightAnchor.constraint(equalToConstant: 120).isActive = true
        bigVoice.widthAnchor.constraint(equalToConstant: 120).isActive = true
        bigVoice.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bigVoice.topAnchor.constraint(equalTo: viewUnderMainWord.topAnchor, constant: 20).isActive = true
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
