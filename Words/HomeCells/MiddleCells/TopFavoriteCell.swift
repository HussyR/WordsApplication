//
//  TopFavoriteCell.swift
//  Words
//
//  Created by Danil on 15/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class TopFavoriteCell: UICollectionViewCell {
    
    var currentTest : TestTopic?
    
    weak var delegate : CellDelegateForSendingTest?
    
    let data = TestTopic.getTopicsForHomeScroll()
    
    let topScrollCellID = "topScrollCellID"
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        //view.layer.shadowOpacity = 0.1
        //view.layer.shadowRadius = 7
        //view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
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
    
    let topScrollCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private func setupTopScrollCV(){
        
        addSubview(view)
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        view.addSubview(separator1)
        separator1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator1.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator1.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator1.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        view.addSubview(separator2)
        separator2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator2.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator2.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator2.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        view.addSubview(topScrollCV)
        topScrollCV.delegate = self
        topScrollCV.dataSource = self
        topScrollCV.backgroundColor = .clear
        topScrollCV.register(TopFavoriteSmallCell.self, forCellWithReuseIdentifier: topScrollCellID)
        topScrollCV.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topScrollCV.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topScrollCV.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        topScrollCV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        topScrollCV.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTopScrollCV()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TopFavoriteCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topScrollCellID, for: indexPath) as! TopFavoriteSmallCell
        cell.data = data[indexPath.row]
        cell.setupData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80 , height: 102)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapLayerButton(tap: data[indexPath.row])
        
    }
    
}
