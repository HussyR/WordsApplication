//
//  ProgressCell.swift
//  Words


import UIKit

class ProgressCell: UICollectionViewCell {
    
    weak var delegate : CellDelegate?
    
    var image = UIImage(named: "")  {
        didSet {
            avatar.image  = image
        }
    }
    
    let questionMark : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "information")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white        
        return view
    }()
    
    let smallView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Прогресс"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 24)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let beginLabel : UILabel = {
        let label = UILabel()
        label.text = "Начинающий"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 24)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let forNextLevelLabel : UILabel = {
        let label = UILabel()
        label.text = "300 слов до\nуровня студент"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 13)
        label.textColor = UIColor.init(rgb: 0x000000)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separateView : [UIView] = {
        var views = [UIView]()
        for i in 0...2 {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(rgb: 0xd8d8d8).withAlphaComponent(0.6)
        views.append(view)
        }
        return views
    }()
    
    let circle : CAShapeLayer  = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 15
        layer.strokeColor = UIColor(rgb: 0xE42C64).cgColor
        layer.lineCap = .round
        layer.strokeStart = 0
        layer.strokeEnd = 0.005
        return layer
    }()
    
    let shadowCircle : CAShapeLayer  = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor(white: 0, alpha: 0).cgColor
        layer.lineWidth = 15
        layer.strokeColor = UIColor(rgb: 0xF3F3F3).cgColor
        layer.lineCap = .round
        layer.strokeStart = 0
        layer.strokeEnd = 1
        return layer
    }()
    
    let avatar: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = UIColor.init(white: 0, alpha: 1)
        iv.layer.cornerRadius = 90
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "GreatPlus")
        return iv
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        print("work")
        if touch.view == questionMark {
            
            delegate?.didTapLayerButton(tap: "alertProgress")
            
        }
    }
    
    public func getRank() {
        switch Double(learnWords) {
        case 0..<UserLevels.student:
            beginLabel.text = "Начинающий"
        case UserLevels.student..<UserLevels.znatok:
            beginLabel.text = "Студент"
        case UserLevels.znatok..<UserLevels.master:
            beginLabel.text = "Знаток"
        case UserLevels.master..<UserLevels.professionsal:
            beginLabel.text = "Мастер"
        case UserLevels.professionsal..<UserLevels.native:
            beginLabel.text = "Профессионал"
        case UserLevels.native...100000:
            beginLabel.text = "Носитель"
        default:
            break
        }
    }
    
    public func getProgress() {
        var percent : Double = 0.005
        let myWords = Double(learnWords)
        switch Double(learnWords) {
        case 1..<UserLevels.student:
            let levelMinusMyWords = Int(UserLevels.student - myWords)
            forNextLevelLabel.text = String(levelMinusMyWords) + getCorrectWords(number: levelMinusMyWords) + "\nдо уровня студент"
            percent = Double(myWords / UserLevels.student)
        case UserLevels.student..<UserLevels.znatok:
            let levelMinusMyWords = Int(UserLevels.znatok - myWords)
            forNextLevelLabel.text = String(levelMinusMyWords) + getCorrectWords(number: levelMinusMyWords) + "\nдо уровня Знаток"
            percent = Double((myWords - UserLevels.student) / (UserLevels.znatok - UserLevels.student))
        case UserLevels.znatok..<UserLevels.master:
            let levelMinusMyWords = Int(UserLevels.master - myWords)
            forNextLevelLabel.text = String(levelMinusMyWords) + getCorrectWords(number: levelMinusMyWords) + "\nдо уровня Мастер"
            percent = Double((myWords - UserLevels.znatok) / (UserLevels.master - UserLevels.znatok))
        case UserLevels.master..<UserLevels.professionsal:
            let levelMinusMyWords = Int(UserLevels.professionsal - myWords)
            forNextLevelLabel.text = String(levelMinusMyWords) + getCorrectWords(number: levelMinusMyWords) + "\nдо уровня Профессионал"
            percent = Double((myWords - UserLevels.master) / (UserLevels.professionsal - UserLevels.master))
        case UserLevels.professionsal..<UserLevels.native:
            let levelMinusMyWords = Int(UserLevels.native - myWords)
            forNextLevelLabel.text = String(levelMinusMyWords) + getCorrectWords(number: levelMinusMyWords) + "\nдо уровня Носитель"
            percent = Double((myWords - UserLevels.professionsal) / (UserLevels.native - UserLevels.professionsal))
        case UserLevels.native...100000:
            forNextLevelLabel.text = "Вы достигли величайшего мастерства"
            percent = 1
        default:
            break
        }
        
        UIView.animate(withDuration: 1, animations: {
            self.circle.strokeEnd = CGFloat(percent)
        }) { (true) in
            print("Все")
            self.circle.strokeEnd = CGFloat(percent)
        }
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1
        animation.toValue = percent
        print(percent)
        //circle.add(animation, forKey: nil)
        //circle.strokeEnd = CGFloat(percent)
    }
    
    private func setup(){
        getProgress()
        getRank()
        let image2 = defaults.value(forKey: KeysForDefaults.avatarData) as! Data
        image = UIImage(data: image2)
        
        addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        mainView.addSubview(header)
        header.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        
        mainView.addSubview(questionMark)
        questionMark.widthAnchor.constraint(equalToConstant: 24).isActive = true
        questionMark.heightAnchor.constraint(equalToConstant: 24).isActive = true
        questionMark.leadingAnchor.constraint(equalTo: header.trailingAnchor, constant: 10).isActive = true
        questionMark.centerYAnchor.constraint(equalTo: header.centerYAnchor, constant: 2.5).isActive = true
 
        mainView.addSubview(smallView)
        smallView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        smallView.center = CGPoint(x: bounds.width / 2, y: 179)
        
        smallView.layer.addSublayer(shadowCircle)
        let path = UIBezierPath(arcCenter: CGPoint(x: 125, y: 125), radius: 107.5, startAngle: 0, endAngle: .pi * 2, clockwise: true).cgPath
        shadowCircle.path = path
        
        smallView.layer.addSublayer(circle)
        let path2 = UIBezierPath(arcCenter: CGPoint(x: 125, y: 125), radius: 107.5, startAngle: 0, endAngle: .pi * 4/2, clockwise: true).cgPath
        circle.path = path2
        smallView.transform = CGAffineTransform(rotationAngle: .pi * 3/2)
        
        mainView.addSubview(avatar)
        avatar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        avatar.topAnchor.constraint(equalTo: topAnchor, constant: 89).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 180).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        mainView.addSubview(beginLabel)
        beginLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 50).isActive = true
        beginLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        mainView.addSubview(separateView[0])
        separateView[0].heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separateView[0].leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        separateView[0].trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        separateView[0].topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        
        mainView.addSubview(separateView[2])
        separateView[2].heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separateView[2].leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        separateView[2].trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        separateView[2].bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        
        mainView.addSubview(separateView[1])
        separateView[1].centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        separateView[1].heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separateView[1].topAnchor.constraint(equalTo: beginLabel.bottomAnchor, constant: 6).isActive = true
        separateView[1].widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        mainView.addSubview(forNextLevelLabel)
        forNextLevelLabel.topAnchor.constraint(equalTo: separateView[1].bottomAnchor, constant: 6).isActive = true
        forNextLevelLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
