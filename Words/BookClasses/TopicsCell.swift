//
//  TopicsCell.swift
//  Words


import UIKit

class TopicsCell: UICollectionViewCell,CellDelegate, CellDelegateForSendingTest {
    func didTapLayerButton(tap: TestTopic) {
        print("Делегат для передачи теста заработал")
        delegateForPassingTest?.didTapLayerButton(tap: tap)
    }
    
    
    func didTapLayerButton(tap: String) {
        print("Делегат в Topics Cell заработал")
    }
    

    var currentTest : TestTopic?
    
    weak var delegate : CellDelegate?
    weak var delegateForPassingTest : CellDelegateForSendingTest?
    
    let mainCellID = "mainCellID"
    
    let cellID1 = "cellID1"
    let cellID2 = "cellID2"
    let cellID3 = "cellID3"
    let cellID4 = "cellID4"
    let cellID5 = "cellID5"
    let cellID6 = "cellID6"
    
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
        print("I work, too")
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
        mainCV.backgroundColor = UIColor.init(white: 0.97578, alpha: 1)
        mainCV.register(TopScrollMiddleCell.self, forCellWithReuseIdentifier: cellID1)
        mainCV.register(ForBeginnersMiddleCell.self, forCellWithReuseIdentifier: cellID2)
        mainCV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID3)
        mainCV.register(TopicsMiddleCell.self, forCellWithReuseIdentifier: cellID4)
        mainCV.register(BannersCell.self, forCellWithReuseIdentifier: cellID5)
        mainCV.register(AnyWaysMiddleCell.self, forCellWithReuseIdentifier: cellID6)
        mainCV.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainCV.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainCV.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        mainCV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        mainCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension TopicsCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! TopScrollMiddleCell
            cell.delegateForPassingTest = self
            cell.setupMood(true)
            return cell
        }
        if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! ForBeginnersMiddleCell
            cell.myType = .beginners
            cell.delegateForPassingTest = self
            return cell
        }
        if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! BannersCell
            cell.delegateForPassingTest = self
            cell.myType = .first
            return cell
        }
        if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TopicsMiddleCell
            cell.delegateForPassingTest = self
            cell.myType = .topics
            return cell
        }
        if indexPath.row == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! BannersCell
            cell.delegateForPassingTest = self
            cell.myType = .second
            return cell
        }

        if indexPath.row == 5 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TopicsMiddleCell
            cell.delegateForPassingTest = self
            cell.myType = .travelling
            return cell
        }
        if indexPath.row == 6 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! BannersCell
            cell.myType = .third
            cell.delegateForPassingTest = self
            return cell
        }
        if indexPath.row == 7 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! ForBeginnersMiddleCell
            cell.myType = .professions
            cell.delegateForPassingTest = self
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: bounds.width , height: 180)
        }
        if indexPath.row == 1 || indexPath.row == 7  { // UPDATE
            return CGSize(width: bounds.width, height: 224)
        }
        if indexPath.row == 3 || indexPath.row == 5 { // UPDATE
            return CGSize(width: bounds.width , height: 494)
        }
        if indexPath.row == 4 || indexPath.row == 6 || indexPath.row == 2 {  // UPDATE
            return CGSize(width: bounds.width , height: 130)
        }
        
        return CGSize(width: bounds.width , height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            delegate?.didTapLayerButton(tap: "Темы")
        }
        if indexPath.row == 1 {
            delegate?.didTapLayerButton(tap: "Начинающие")
        }
        if indexPath.row == 5 {
            delegate?.didTapLayerButton(tap: "Путешествия")
        }
    }
    
}
