//
//  InfinityMoodsCell.swift
//  Words
//
//  Created by Danil on 15/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class InfinityMoodsCell: UICollectionViewCell {
    
    weak var delegateForPassingTest  : CellDelegateForSendingTest?
    let cellID = "cellID"
    let data = TestTopic.getTopicsForinfinity()
    
    let separator1 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(rgb: 0xd8d8d8).withAlphaComponent(0.7)
        return view
    }()
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Бесконечные режимы"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 30)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorsView : [UIView] = {
        var array : [UIView] = []
        for i in 0...1 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.init(rgb: 0xd8d8d8).withAlphaComponent(0.6)
            array.append(view)
        }
        return array
    }()
    
    let cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        return cv
    }()
    
    private func setupForbeginnersCV(){
        
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        view.addSubview(separator1)
        separator1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator1.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator1.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator1.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        view.addSubview(header)
        header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        
        view.addSubview(cv)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.white
        cv.register(SmallInfCell.self, forCellWithReuseIdentifier: cellID)
        cv.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cv.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 5).isActive = true
        cv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        for i in 0...1 {
            addSubview(separatorsView[i])
            separatorsView[i].leadingAnchor.constraint(equalTo: cv.leadingAnchor, constant: 115).isActive = true
            separatorsView[i].heightAnchor.constraint(equalToConstant: 1).isActive = true
            separatorsView[i].trailingAnchor.constraint(equalTo: cv.trailingAnchor, constant: -25).isActive = true
        }
        
        separatorsView[0].topAnchor.constraint(equalTo: cv.topAnchor, constant: 86).isActive = true
        separatorsView[1].topAnchor.constraint(equalTo: separatorsView[0].bottomAnchor, constant: 86).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setup()
        setupForbeginnersCV()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        
    }
    
}


extension InfinityMoodsCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SmallInfCell
        cell.data = data[indexPath.row]
        cell.setupData()
        switch indexPath.row {
        case 0:
            cell.countOfWords.text = "Огромное количество самых\nвостребованных глаголов"
        case 1:
            cell.countOfWords.text = "Подборка наиболее используемых\nсуществительных"
        case 2:
            cell.countOfWords.text = "Подборка прилагательных по\nпулярности"
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width , height: 86)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateForPassingTest?.didTapLayerButton(tap: data[indexPath.row])
    }
    
}
    

