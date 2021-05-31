//  AboutWordCell.swift
//  Words


import UIKit

class AboutWordCell: UICollectionViewCell {
    
    var indexPath : Int = 0
    var isLoad = false
    var word : Word?
    
    weak var sayDelegate : SayDelegate?
    weak var testDelegate : TestDelegate?
    let speaker = TalkingService()
    
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
    
    let viewUnderExamples : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 7
        return view
    }()
    
    let mainWord : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "word"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 30)
        return label
    }()
    
    let translateWord : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SourceSansPro-Bold", size: 26)
        label.text = "слово"
        label.textColor = .white
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true;
        return label
    }()
    
    let twoExamples : [UILabel] = {
        
        var labels = [UILabel]()
        for _ in 0...1 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "The first test"
            label.numberOfLines = 0
            label.font = UIFont(name: "SourceSansPro-Regular", size: 17)
            labels.append(label)
        }
        return labels
    }()
    
    let makeFavoriteImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .clear
        return image
    }()
    
    let voiceImages : UIImageView = {
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
        button.setTitle("Дальше", for: .normal)
        button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainBlue()
        return button
    }()
    
    @objc func skipAction() {
        testDelegate?.didTapButton(tap: .skip, indexPath : indexPath)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    open func setupNeededWord (indexPath : Int){
        self.indexPath = indexPath
        //twoExamples[0].text = word!.example1
        //twoExamples[1].text = word!.example2
        mainWord.text = word!.word
        translateWord.text = word!.translate
        if indexPath % 50 == 0 {
            sayDelegate?.say(phrase: word!.word)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if touch.view == voiceImages {
            speaker.say(word!.word)
        }
    }
    
    public func sayWord() {
        speaker.say(word!.word)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(){
        buttonNext.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        
        backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        
        addSubview(viewUnderMainWord)
        viewUnderMainWord.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewUnderMainWord.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        viewUnderMainWord.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        viewUnderMainWord.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        viewUnderMainWord.addSubview(makeFavoriteImage)
        makeFavoriteImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        makeFavoriteImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        makeFavoriteImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        makeFavoriteImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        viewUnderMainWord.addSubview(voiceImages)
        voiceImages.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        voiceImages.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        voiceImages.heightAnchor.constraint(equalToConstant: 26).isActive = true
        voiceImages.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
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
        translateWord.trailingAnchor.constraint(equalTo: viewUnderTranslateWord.trailingAnchor, constant: -20).isActive = true
        
    }

    
    
}

