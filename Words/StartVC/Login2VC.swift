//
//  Login2VC.swift
//  Words


import UIKit

class Login2VC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = "UnderStand"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 34)
        label.textColor = UIColor(white: 1, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        return label
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Как тебя зовут?"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 28)
        label.textColor = UIColor(white: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    let button : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = UIFont(name: "SourceSansPro-SemiBold", size: 28)
        button.backgroundColor = UIColor.init(rgb: 0x3960D3)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let textField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Имя"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0x4169E1)
        textField.delegate = self
        setupUI()
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction() {
        
        if textField.text == "" {
            return
        }
        userName = textField.text!
        isLogin = true
        setIndex(type: .isLogin)
        setIndex(type: .userName)
        
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupUI() {
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        
        view.addSubview(textField)
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 6).isActive = true
        
        view.addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
    }
    
    
    
}

extension Login2VC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        view.endEditing(true)
        return true
    }
}
