//
//  PartsOfSpeechCell.swift
//  Words
//
//  Created by Danil on 14/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class PartsOfSpeechCell: UICollectionViewCell,CellDelegateForSendingTest {
    
    func didTapLayerButton(tap: TestTopic) {
        delegateForPassingTest?.didTapLayerButton(tap: tap)
    }
    
    
    let mainCellID = "mainCellID"
    
    let cellID1 = "cellID1"
    let cellID2 = "cellID2"
    let cellID3 = "cellID3"
    let cellID4 = "cellID4"
    let cellID5 = "cellID5"
    let cellID6 = "cellID6"
    
    weak var delegateForPassingTest : CellDelegateForSendingTest?
    
    let mainCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    override init(frame: CGRect) {
        print("Я в деле")
        super.init(frame: frame)
        backgroundColor = .yellow
        setupMainCV()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    private func setupMainCV() {
        addSubview(mainCV)
        mainCV.delegate = self
        mainCV.dataSource = self
        mainCV.backgroundColor = UIColor.init(white: 0.98, alpha: 1)
        mainCV.register(TopScrollMiddleCell.self, forCellWithReuseIdentifier: cellID1)
        mainCV.register(InfinityMoodsCell.self, forCellWithReuseIdentifier: cellID2)
        mainCV.register(VerbsModesCell.self, forCellWithReuseIdentifier: cellID3)
        mainCV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID4)
        mainCV.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainCV.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainCV.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainCV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        mainCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension PartsOfSpeechCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! TopScrollMiddleCell
            cell.delegateForPassingTest = self
            cell.setupMood(false)
            return cell
        }
        if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! InfinityMoodsCell
            cell.delegateForPassingTest = self
            return cell
        }
        if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath)
            cell.backgroundColor = .clear
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! VerbsModesCell
            cell.delagate = self
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: bounds.width , height: 180)
        }
        if indexPath.row == 1 {
            return CGSize(width: bounds.width , height: 328)
        }
        
        if indexPath.row == 2 {
            return CGSize(width: bounds.width, height: 6)
        }
        
        if indexPath.row == 3 {
            return CGSize(width: bounds.width, height: 191)
        }
        
        
        
        return CGSize(width: bounds.width , height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
