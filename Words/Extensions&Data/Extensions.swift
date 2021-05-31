//
//  Extensions.swift
//  Words


import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static var mainBlue = {
        return UIColor(rgb: 0x4169E1)
    }
    static var secondWhite = {
        return UIColor(rgb: 0xFCFCFC)
    }
}

class NaVView: UIView {
    
    var widthColumnConstraint: NSLayoutConstraint?
    
    var currentProgress : Double = 0 {
        didSet {
            widthColumnConstraint?.constant = CGFloat(currentProgress) * 206
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    let shadowViewProgress : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0.25)
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    let progressView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 1)
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    let imageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "medal")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 36).isActive = true
        widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(shadowViewProgress)
        shadowViewProgress.heightAnchor.constraint(equalToConstant: 3.5).isActive = true
        shadowViewProgress.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        shadowViewProgress.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10).isActive = true
        shadowViewProgress.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(progressView)
        progressView.heightAnchor.constraint(equalToConstant: 3.5).isActive = true
        progressView.leadingAnchor.constraint(equalTo: shadowViewProgress.leadingAnchor).isActive = true
        //progressView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        progressView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        widthColumnConstraint = progressView.widthAnchor.constraint(equalToConstant: 0)
        widthColumnConstraint?.isActive = true
        widthColumnConstraint?.constant = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
