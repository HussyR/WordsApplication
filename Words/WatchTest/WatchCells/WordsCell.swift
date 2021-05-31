//
//  WordsCell.swift
//  Words
//
//  Created by Danil on 16/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class WordsCell: UICollectionViewCell {
    
    var words = [Word]()
    let cellID = "cellID"
    weak var delegate : CellDelegate?
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.init(rgb: 0xD8D8D8).withAlphaComponent(0.6)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setup()
    }
    
    public func setupData () {
        tableView.reloadData()
    }
    
    private func setup(){
        addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.register(WordSmallCell.self, forCellReuseIdentifier: cellID)
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WordsCell : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WordSmallCell
        cell.data = words[indexPath.row]
        cell.setupData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        delegate?.didTapLayerButton(tap: String(indexPath.row))
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
