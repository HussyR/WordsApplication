//
//  DiagramCell.swift
//  Words


import UIKit

class DiagramCell: UITableViewCell {

    var color : UIColor = .black
    var header = ""
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7.5
        view.backgroundColor = .black
        return view
    }()
    
    let word : UILabel = {
        let label = UILabel()
        label.text = "Word"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 12)
        label.textColor = UIColor(rgb: 0x8d8d8d)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(color: UIColor, header: String) {
        self.color = color
        self.header = header
        word.text = header
        view.backgroundColor = color
    }
    
    private func setup() {
        
        addSubview(view)
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44.5).isActive = true
        view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: 15).isActive = true
        view.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        addSubview(word)
        word.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20.5).isActive = true
        word.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
}

