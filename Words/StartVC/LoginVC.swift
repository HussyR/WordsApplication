//
//  LoginVC.swift
//  Words

import UIKit

class LoginVC: UIViewController {
    
    let welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 34)
        label.textColor = UIColor(white: 1, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let descLabel : UILabel = {
        let label = UILabel()
        label.text = "C приложением MyApp вы сможете\nза кратчайшее время, максимально\nувеличить свой словарный запас"
        label.numberOfLines = 0
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 16)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true;
        label.minimumScaleFactor = 0.5 ;
        return label
    }()
    
    let button : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont(name: "SourceSansPro-SemiBold", size: 28)
        button.backgroundColor = UIColor.init(rgb: 0x3960D3)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let bigView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let mediumViews : [UIView] = {
        var array : [UIView] = []
        for i in 0...2 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.clear
            array.append(view)
        }
        return array
    }()
    
    let imageViews : [UIImageView] = {
        var array : [UIImageView] = []
        for i in 0...2 {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.clear
            view.layer.shadowOpacity = 0.1
            view.layer.shadowRadius = 4
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            array.append(view)
        }
        array[0].image = UIImage(named: "picture1")
        array[1].image = UIImage(named: "picture2")
        array[2].image = UIImage(named: "picture3")
        return array
    }()
    
    let smallViews : [UIView] = {
        var array : [UIView] = []
        for i in 0...2 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.blue
            view.layer.cornerRadius = 10
            array.append(view)
        }
        array[0].backgroundColor = UIColor(rgb: 0xFF7058).withAlphaComponent(0.9)
        array[1].backgroundColor = UIColor(rgb: 0xF94C7B).withAlphaComponent(0.9)
        array[2].backgroundColor = UIColor(rgb: 0x14C966).withAlphaComponent(0.9)
        return array
    }()
    
    let labels : [UILabel] = {
        var array : [UILabel] = []
        
        for _ in 0...2 {
            let label = UILabel()
            label.text = ""
            label.font = UIFont(name: "SourceSansPro-Bold", size: 19)
            label.textColor = UIColor(white: 1, alpha: 1)
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontSizeToFitWidth = true;
            label.minimumScaleFactor = 0.5 ;
            array.append(label)
        }
        array[0].text = "4000 слов"
        array[1].text = "50 тематик"
        array[2].text = "5 способов выучить"
        
        return array
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0x4169E1)
        setupUI()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func buttonAction() {
        if !isLogin {
            performSegue(withIdentifier: "segue2", sender: self)
        } else {
            performSegue(withIdentifier: "segue1", sender: self)
        }
    }
    
    private func setupUI () {
        
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        
        //view.addSubview(descLabel)
        //descLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor).isActive = true
        //descLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 12).isActive = true
        
        let topInset = view.safeAreaInsets.top + 60 + 43
        let bottomInset = CGFloat(60) + view.safeAreaInsets.bottom
        let height = view.frame.height - bottomInset - topInset - 370
        view.addSubview(bigView)
        bigView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        bigView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        bigView.heightAnchor.constraint(equalToConstant: 370).isActive = true
        bigView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: height / 2).isActive = true
        
        for i in 0...2 {
            bigView.addSubview(mediumViews[i])
            mediumViews[i].leadingAnchor.constraint(equalTo: bigView.leadingAnchor).isActive = true
            mediumViews[i].trailingAnchor.constraint(equalTo: bigView.trailingAnchor).isActive = true
            mediumViews[i].heightAnchor.constraint(equalToConstant: 110).isActive = true
        }
        mediumViews[0].topAnchor.constraint(equalTo: bigView.topAnchor).isActive = true
        mediumViews[1].topAnchor.constraint(equalTo: mediumViews[0].bottomAnchor, constant: 20).isActive = true
        mediumViews[2].topAnchor.constraint(equalTo: mediumViews[1].bottomAnchor, constant: 20).isActive = true
        
        for i in 0...2 {
            mediumViews[i].addSubview(smallViews[i])
            smallViews[i].leadingAnchor.constraint(equalTo: mediumViews[i].leadingAnchor).isActive = true
            smallViews[i].trailingAnchor.constraint(equalTo: mediumViews[i].trailingAnchor).isActive = true
            smallViews[i].heightAnchor.constraint(equalToConstant: 60).isActive = true
            smallViews[i].topAnchor.constraint(equalTo: mediumViews[i].topAnchor, constant: 34).isActive = true
        }
        
        for i in 0...2 {
            mediumViews[i].addSubview(imageViews[i])
            imageViews[i].topAnchor.constraint(equalTo: mediumViews[i].topAnchor).isActive = true
            imageViews[i].heightAnchor.constraint(equalToConstant: 110).isActive = true
            imageViews[i].widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
        
        imageViews[0].leadingAnchor.constraint(equalTo: mediumViews[0].leadingAnchor, constant: 35).isActive = true
        imageViews[1].leadingAnchor.constraint(equalTo: mediumViews[1].leadingAnchor, constant: 25).isActive = true
        imageViews[2].leadingAnchor.constraint(equalTo: mediumViews[2].leadingAnchor, constant: 15).isActive = true
        
        for i in 0...2 {
            smallViews[i].addSubview(labels[i])
            labels[i].topAnchor.constraint(equalTo: smallViews[i].topAnchor, constant: 18).isActive = true
            labels[i].leadingAnchor.constraint(equalTo: imageViews[i].trailingAnchor, constant: 15).isActive = true
            labels[i].trailingAnchor.constraint(equalTo: smallViews[i].trailingAnchor, constant: -15).isActive = true
        }
        
        view.addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
}
