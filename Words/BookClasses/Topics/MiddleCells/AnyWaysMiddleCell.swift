//
//  AnyWaysMiddleCell.swift
//  Words
//
//  Created by Danil on 15/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class AnyWaysMiddleCell: UICollectionViewCell,CellDelegateForSendingTest {
    
    func didTapLayerButton(tap: TestTopic) {
        delegateForPassingTest?.didTapLayerButton(tap: tap)
    }
    
    
    let cellID = "cellID"
    weak var delegateForPassingTest : CellDelegateForSendingTest?
    let data = TestTopic.getAnyWaysTopics()
    
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
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        //view.layer.shadowOpacity = 0.1
        //view.layer.shadowRadius = 7
        //view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "На все случаи жизни"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 30)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupCV()
    }
    
    private func setupCV(){
        view.addSubview(cv)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(AnyWaysCell.self, forCellWithReuseIdentifier: cellID)
        cv.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cv.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 5).isActive = true
        cv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        
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
        
        view.addSubview(separator2)
        separator2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator2.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator2.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator2.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        view.addSubview(header)
        header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        
        
    }
    
}

extension AnyWaysMiddleCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AnyWaysCell
        cell.delegateForPassingTest = self
        print(data.count)
        print(indexPath.row)
        switch indexPath.row  {
        case 0 :
            cell.setupData(data: [data[0], data[1], data[2]])
            cell.cv.reloadData()
        case 1:
            cell.setupData(data: [data[3], data[4], data[5]])
            cell.cv.reloadData()
        case 2:
            cell.setupData(data: [data[6], data[7], data[8]])
            cell.cv.reloadData()
        case 3:
            cell.setupData(data: [data[9], data[10], data[11]])
            cell.cv.reloadData()
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = bounds.width - 45
        return CGSize(width: width , height: 258)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}
