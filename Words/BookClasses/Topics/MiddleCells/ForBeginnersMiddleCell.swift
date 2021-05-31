//
//  FoeBeginnersMiddleCell.swift
//  Words
//
//  Created by Danil on 14/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

enum TypeOfVerticalCell {
    case beginners
    case professions
    case add
}

class ForBeginnersMiddleCell: UICollectionViewCell {
    
    let forBeginnersCellID = "forBeginnersCellID"

    weak var delegateForPassingTest  : CellDelegateForSendingTest?
    
    var data = TestTopic.getTopicsForBeginners()
    var action : String = ""
    /*
    var isForBeginners = true {
        didSet {
            if isForBeginners == true {
                data = TestTopic.getTopicsForBeginners()
                header.text = "Для начинающих"
                strela.alpha = 1
            } else {
                data = TestTopic.getTopicsForProfessions()
                header.text = "Профессии"
                strela.alpha = 0
            }
            forBeginnersCV.reloadData()
        }
    }
    */
    var myType : TypeOfVerticalCell = .beginners {
        didSet {
            
            switch myType {
            case .beginners:
                data = TestTopic.getTopicsForBeginners()
                header.text = "Для начинающих"
                strela.alpha = 1
            case .professions:
                data = TestTopic.getTopicsForProfessions()
                header.text = "Профессии"
                strela.alpha = 0
            case .add:
                print("Реклама")
            }
            
            forBeginnersCV.reloadData()
        }
    }
    
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
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Для начинающих"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 30)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let strela : UIImageView = {
        let image = UIImageView(image: UIImage(named: "strela"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let forBeginnersCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
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
        
        view.addSubview(strela)
        strela.heightAnchor.constraint(equalToConstant: 12).isActive = true
        strela.widthAnchor.constraint(equalToConstant: 8).isActive = true
        strela.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -10).isActive = true
        strela.leadingAnchor.constraint(equalTo: header.trailingAnchor, constant: 12).isActive = true
        
        view.addSubview(forBeginnersCV)
        forBeginnersCV.delegate = self
        forBeginnersCV.dataSource = self
        forBeginnersCV.backgroundColor = UIColor.white
        forBeginnersCV.register(VerticalCell.self, forCellWithReuseIdentifier: forBeginnersCellID)
        
        forBeginnersCV.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        forBeginnersCV.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        forBeginnersCV.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 13).isActive = true
        forBeginnersCV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        forBeginnersCV.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
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

extension ForBeginnersMiddleCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forBeginnersCellID, for: indexPath) as! VerticalCell
        cell.data = data[indexPath.row]
        cell.setupData()
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100 , height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        delegateForPassingTest?.didTapLayerButton(tap: data[indexPath.row])
    }
    
}

