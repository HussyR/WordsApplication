//
//  FinalCell.swift
//  Words
//
//  Created by Danil on 01/08/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class FinalCell: UICollectionViewCell {
    
    weak var testDelegate : TestDelegate?
    
    var indexPath = 0
    let cellID = "cellID"
    var maxCount = 10
    var counts = [1,1,1,1,1,1]
    let headers = ["Существительные", "Глаголы", "Прилагательные", "Предлоги", "Наречия", "Союзы"]
    let colors = [UIColor(rgb: 0xF5D56E),UIColor(rgb: 0xFF7058),UIColor(rgb: 0x576DDC),UIColor(rgb: 0x885AD8),UIColor(rgb: 0x14C966),UIColor(rgb: 0xF94C7B)]
    
    
    
    let buttonNext : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: 24)
        button.backgroundColor = .mainBlue()
        return button
    }()
    
    let countWordslabel : UILabel = {
        let label = UILabel()
        label.text = "Вы выучили 10 слов"
        label.font = UIFont(name: "SourceSansPro-SemiBold", size: 27)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let theMainView :UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        return view
    }()
    
    let mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    let secondMainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 36
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.init(rgb: 0xD8D8D8).withAlphaComponent(0.6)
        
        return tableView
    }()
    
    let columns : [UIView] = {
        var array = [UIView]()
        for i in 0...5 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 2
            array.append(view)
        }
        return array
    }()
    
    let countLabels : [UILabel] = {
        var array = [UILabel]()
        for i in 0...5 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = UIFont(name: "SourceSansPro-Bold", size: 12)
            label.textColor = UIColor(rgb: 0x8d8d8d)
            array.append(label)
        }
        return array
    }()
    
    @objc func buttonAction() {
        testDelegate?.didTapButton(tap: .skip, indexPath: indexPath)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        return 
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(rgb: 0xfcfcfc)
        setup()
        buttonNext.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var heightColumnConstraint1: NSLayoutConstraint?
    var heightColumnConstraint2: NSLayoutConstraint?
    var heightColumnConstraint3: NSLayoutConstraint?
    var heightColumnConstraint4: NSLayoutConstraint?
    var heightColumnConstraint5: NSLayoutConstraint?
    var heightColumnConstraint6: NSLayoutConstraint?

    
    public func setupNeed() {
        countWordslabel.text = "Вы выучили \(maxCount)" + getCorrectWords(number: maxCount)
        if maxCount != 10 {
            buttonNext.setTitle("Завершить", for: .normal)
        }
        setupFirstPart()
        setupSecondPart()
        
        heightColumnConstraint1?.constant = getHeight(maxCount: maxCount, count: counts[0])
        heightColumnConstraint2?.constant = getHeight(maxCount: maxCount, count: counts[1])
        heightColumnConstraint3?.constant = getHeight(maxCount: maxCount, count: counts[2])
        heightColumnConstraint4?.constant = getHeight(maxCount: maxCount, count: counts[3])
        heightColumnConstraint5?.constant = getHeight(maxCount: maxCount, count: counts[4])
        heightColumnConstraint6?.constant = getHeight(maxCount: maxCount, count: counts[5])
    }
    
    private func setupFirstPart() {
        theMainView.addSubview(mainView)
        mainView.leadingAnchor.constraint(equalTo: theMainView.leadingAnchor, constant: 20).isActive = true
        mainView.trailingAnchor.constraint(equalTo: theMainView.trailingAnchor, constant: -20).isActive = true
        mainView.topAnchor.constraint(equalTo: countWordslabel.bottomAnchor, constant: 20).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        let widthForColumn = (bounds.width - 140) / 6
        print(widthForColumn)
        
        for i in 0...5 {
            mainView.addSubview(columns[i])
            columns[i].backgroundColor = colors[i] // SET COLOR IN VEIW
            columns[i].bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20).isActive = true
            columns[i].widthAnchor.constraint(equalToConstant: widthForColumn).isActive = true
        }
        
        columns[0].leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        columns[1].leadingAnchor.constraint(equalTo: columns[0].trailingAnchor, constant: 20).isActive = true
        columns[2].leadingAnchor.constraint(equalTo: columns[1].trailingAnchor, constant: 20).isActive = true
        columns[3].leadingAnchor.constraint(equalTo: columns[2].trailingAnchor, constant: 20).isActive = true
        columns[4].leadingAnchor.constraint(equalTo: columns[3].trailingAnchor, constant: 20).isActive = true
        columns[5].leadingAnchor.constraint(equalTo: columns[4].trailingAnchor, constant: 20).isActive = true
        
        for i in 0...5 {
            mainView.addSubview(countLabels[i])
            countLabels[i].text = String(counts[i]) // УСТАНОВКА ТЕКСТА В LABEL
            countLabels[i].centerXAnchor.constraint(equalTo: columns[i].centerXAnchor).isActive = true
            countLabels[i].topAnchor.constraint(equalTo: columns[i].bottomAnchor, constant: 2).isActive = true
        }
    }
    
    private func setupSecondPart(){
        theMainView.addSubview(secondMainView)
        secondMainView.heightAnchor.constraint(equalToConstant: 216).isActive = true
        secondMainView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 10).isActive = true
        secondMainView.leadingAnchor.constraint(equalTo: theMainView.leadingAnchor).isActive = true
        secondMainView.trailingAnchor.constraint(equalTo: theMainView.trailingAnchor).isActive = true
        
        secondMainView.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(DiagramCell.self, forCellReuseIdentifier: cellID)
        tableView.leadingAnchor.constraint(equalTo: secondMainView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: secondMainView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: secondMainView.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: secondMainView.bottomAnchor).isActive = true
    }
    
    
    
    private func setup() {
        
        heightColumnConstraint1 = columns[0].heightAnchor.constraint(equalToConstant: getHeight(maxCount: maxCount, count: counts[0]))
        heightColumnConstraint1?.isActive = true
        heightColumnConstraint1?.constant = 0
        
        heightColumnConstraint2 = columns[1].heightAnchor.constraint(equalToConstant: getHeight(maxCount: maxCount, count: counts[1]))
        heightColumnConstraint2?.isActive = true
        heightColumnConstraint2?.constant = 0
        
        heightColumnConstraint3 = columns[2].heightAnchor.constraint(equalToConstant: getHeight(maxCount: maxCount, count: counts[2]))
        heightColumnConstraint3?.isActive = true
        heightColumnConstraint3?.constant = 0
        
        heightColumnConstraint4 = columns[3].heightAnchor.constraint(equalToConstant: getHeight(maxCount: maxCount, count: counts[3]))
        heightColumnConstraint4?.isActive = true
        heightColumnConstraint4?.constant = 0
        
        heightColumnConstraint5 = columns[4].heightAnchor.constraint(equalToConstant: getHeight(maxCount: maxCount, count: counts[4]))
        heightColumnConstraint5?.isActive = true
        heightColumnConstraint5?.constant = 0
        
        heightColumnConstraint6 = columns[5].heightAnchor.constraint(equalToConstant: getHeight(maxCount: maxCount, count: counts[5]))
        heightColumnConstraint6?.isActive = true
        heightColumnConstraint6?.constant = 0
        
        addSubview(buttonNext)
        buttonNext.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        buttonNext.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        buttonNext.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        buttonNext.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(theMainView)
        theMainView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        theMainView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        theMainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        theMainView.bottomAnchor.constraint(equalTo: buttonNext.topAnchor, constant: -10).isActive = true
        
        theMainView.addSubview(countWordslabel)
        countWordslabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        countWordslabel.topAnchor.constraint(equalTo: theMainView.topAnchor, constant: 15).isActive = true
    }
    
    private func getHeight(maxCount: Int, count: Int) -> CGFloat {
        return CGFloat(200 / maxCount * count)
    }
    
}

extension FinalCell : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DiagramCell
        cell.setupData(color: colors[indexPath.row], header: headers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
