//
//  BannersCell.swift
//  Words


import UIKit

enum TypeOfBanners {
    case first
    case second
    case third
}

class BannersCell: UICollectionViewCell {
    
    let cellID = "cellID"
    weak var delegateForPassingTest  : CellDelegateForSendingTest?
    var data = TestTopic.getBannersTopics()
    var colors = [UIColor]()
    
    var myType : TypeOfBanners = .first {
        didSet {
            switch myType {
            case .first:
                data = TestTopic.getAddTopics()
                colors = [UIColor(rgb: 0x0E2F44), UIColor(rgb: 0x205C79), UIColor(rgb: 0x0E2F44),UIColor(rgb: 0xFF7058), UIColor(rgb: 0xFFA991), UIColor(rgb: 0xFF7058)]
                
            case .second:
                data = TestTopic.getBannersTopics()
                colors = [UIColor(rgb: 0x0E2F44), UIColor(rgb: 0x205C79), UIColor(rgb: 0x0E2F44),UIColor(rgb: 0xFF7058), UIColor(rgb: 0xFFA991), UIColor(rgb: 0xFF7058)]
            case .third:
                data = TestTopic.getBannersTopics2()
                colors = [UIColor(rgb: 0xB8535F), UIColor(rgb: 0xE16674), UIColor(rgb: 0xB8535F),UIColor(rgb: 0xE3B98D), UIColor(rgb: 0xE6BE94), UIColor(rgb: 0xE3B98D)]
            }
            cv.reloadData()
        }
    }
    
    let cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 25
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private func setupCV(){
        addSubview(cv)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.clear
        cv.register(SmallBannerCell.self, forCellWithReuseIdentifier: cellID)
        
        cv.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cv.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        cv.heightAnchor.constraint(equalToConstant: 132).isActive = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setup()
        setupCV()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        
    }
    
}

extension BannersCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SmallBannerCell
        cell.data = data[indexPath.row]
        cell.setupData()
        
        if indexPath.row == 0 {
            cell.gradient.colors = [colors[0].cgColor, colors[1].cgColor, colors[2].cgColor]
        } else {
            cell.gradient.colors = [colors[3].cgColor, colors[4].cgColor, colors[5].cgColor]
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 260 , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateForPassingTest?.didTapLayerButton(tap: (indexPath.row == 0 ? data[0] : data[1]))
    }
    
}
