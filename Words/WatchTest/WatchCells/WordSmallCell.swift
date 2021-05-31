//
//  WordSmallCell.swift
//  Words


import UIKit

class WordSmallCell: UITableViewCell {
    
    var data : Word?
    
    let word : UILabel = {
        let label = UILabel()
        label.text = "Word"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 16)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let translation : UILabel = {
        let label = UILabel()
        label.text = "Слово"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 16)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData() {
        word.text = data!.word
        translation.text = data!.translate
    }
    
    private func setup() {
        
        addSubview(word)
        word.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        word.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        addSubview(translation)
        translation.leadingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        translation.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
    }
    
}
