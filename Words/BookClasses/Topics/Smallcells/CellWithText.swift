//
//  CellWithText.swift
//  Words


import UIKit

class CellWithText: UICollectionViewCell {
    let text : UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = UIColor.white
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        addSubview(text)
        text.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }

    
}
