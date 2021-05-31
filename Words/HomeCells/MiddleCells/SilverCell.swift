//
//  SilverCell.swift
//  Words


import UIKit

class SilverCell: UICollectionViewCell {
    
    weak var alertDelegate : CellDelegate?
    weak var delegate : CellDelegateForSendingTest?
    var data = TestTopic.getSilverAndGoldTests()
    
    let questionMark : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "information")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let separator1 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(rgb: 0xd8d8d8).withAlphaComponent(0.7)
        return view
    }()
    
    let separator2 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(rgb: 0xd8d8d8).withAlphaComponent(0.7)
        return view
    }()
    
    let mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        //view.layer.shadowOpacity = 0.1
        //view.layer.shadowRadius = 7
        //view.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        return view
    }()
    
    let smallView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 7
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Ежедневный тест"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 30)
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
        iv.image = UIImage(named: image1[0].image)
        return iv
    }()
    
    let descriptionForView : UILabel = {
        let label = UILabel()
        label.text = "Подборка из 10 слов на\nкаждый день"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 13)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    let headerForView : UILabel = {
        let label = UILabel()
        label.text = "Silver Words"
        label.font = UIFont(name: "SourceSansPro-Bold", size: 25)
        label.textColor = UIColor(white: 1, alpha: 1)
        label.textAlignment = .right
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if touch.view == questionMark {
            
            alertDelegate?.didTapLayerButton(tap: "ws")

        }
    }
    
    private func setup(){
        
        addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        mainView.addSubview(separator1)
        separator1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator1.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator1.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator1.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        mainView.addSubview(separator2)
        separator2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator2.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator2.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator2.topAnchor.constraint(equalTo: topAnchor).isActive = true
 
        mainView.addSubview(header)
        header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        
        mainView.addSubview(questionMark)
        questionMark.widthAnchor.constraint(equalToConstant: 24).isActive = true
        questionMark.heightAnchor.constraint(equalToConstant: 24).isActive = true
        questionMark.leadingAnchor.constraint(equalTo: header.trailingAnchor, constant: 10).isActive = true
        questionMark.centerYAnchor.constraint(equalTo: header.centerYAnchor, constant: 2.5).isActive = true
        
        mainView.addSubview(smallView)
        smallView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 13).isActive = true
        smallView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        smallView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        smallView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let gradient = CAGradientLayer()
        gradient.locations = [0.0, 0.33, 0.66, 1.0]
        gradient.colors = [UIColor.init(rgb: 0x0762A3).withAlphaComponent(0.7).cgColor,
                           UIColor.init(rgb: 0x047AD0).withAlphaComponent(0.55).cgColor,
                           UIColor.init(rgb: 0x047AD0).withAlphaComponent(0.55).cgColor,
                           UIColor.init(rgb: 0x0762A3).withAlphaComponent(0.7).cgColor,]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.width - 40, height: 150)
        gradient.cornerRadius = 10
        print(mainView.bounds)
        smallView.layer.addSublayer(gradient)
        
        smallView.addSubview(headerForView)
        headerForView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -34).isActive = true
        headerForView.topAnchor.constraint(equalTo: smallView.topAnchor, constant: 29).isActive = true
        
        smallView.addSubview(descriptionForView)
        descriptionForView.topAnchor.constraint(equalTo: headerForView.bottomAnchor, constant: 3).isActive = true
        descriptionForView.trailingAnchor.constraint(equalTo: headerForView.trailingAnchor).isActive = true
        
        smallView.addSubview(imageForView)
        imageForView.topAnchor.constraint(equalTo: smallView.topAnchor, constant: 45).isActive = true
        imageForView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageForView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageForView.leadingAnchor.constraint(equalTo: headerForView.trailingAnchor, constant: 35).isActive = true
        
        mainView.addSubview(button)
        button.topAnchor.constraint(equalTo: smallView.bottomAnchor, constant: 14).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    
    @objc func buttonAction() {
        delegate?.didTapLayerButton(tap: data[0])
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
