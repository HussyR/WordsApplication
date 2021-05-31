//
//  AnyWaysCell.swift
//  Words
//
//  Created by Danil on 15/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class AnyWaysCell: UICollectionViewCell {
    
    var isLoad = false
    let cellID = "cellID"
    weak var delegateForPassingTest : CellDelegateForSendingTest?
    var data = [TestTopic]()
    
    let cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = true
        return cv
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
    
    public func setupData(data: [TestTopic]) {
        print(self.data.count)
        print(data[0].header)
        print(data[1].header)
        print(data[2].header)
        self.data = data
    }
    
    private func setupCV(){
        addSubview(cv)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.white
        cv.register(AnyWaysSmallCell.self, forCellWithReuseIdentifier: cellID)
        
        cv.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cv.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cv.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        addSubview(separatorsView[0])
        addSubview(separatorsView[1])
        
        separatorsView[0].heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorsView[0].leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90).isActive = true
        separatorsView[0].trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        separatorsView[0].topAnchor.constraint(equalTo: cv.topAnchor, constant: 86).isActive = true
        
        separatorsView[1].heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorsView[1].leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90).isActive = true
        separatorsView[1].trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        separatorsView[1].bottomAnchor.constraint(equalTo: cv.bottomAnchor, constant: -86).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupCV()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        backgroundColor = .brown
        
        
    }
    
}

extension AnyWaysCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AnyWaysSmallCell
        cell.data = data[indexPath.row]
        print("In the middle cell")
        print(indexPath.row)
        cell.setupData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width , height: 86)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            delegateForPassingTest?.didTapLayerButton(tap: data[0])
        case 1:
            delegateForPassingTest?.didTapLayerButton(tap: data[1])
        case 2:
            delegateForPassingTest?.didTapLayerButton(tap: data[2])
        default:
            break
        }
        
        
    }
    
}
