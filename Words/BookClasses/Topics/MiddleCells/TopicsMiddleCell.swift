//
//  TopicsMiddleCell.swift
//  Words

import UIKit

enum TypeOfHorizontalCell {
    case topics
    case travelling
    case add
}

class TopicsMiddleCell: UICollectionViewCell {
    
    var data = TestTopic.getMainTopics()
    
    // Update
    /*
    var isMainTopics = true {
        didSet {
            if isMainTopics == true {
                data = TestTopic.getMainTopics()
                header.text = "Тематики"
            } else {
                data = TestTopic.getTravellingTopics()
                header.text = "В путешествии"
            }
        }
    }
    */
    var myType : TypeOfHorizontalCell = .topics {
        didSet {
            switch myType {
            case .topics:
                data = TestTopic.getMainTopics()
                header.text = "Тематики"
                strela.alpha = 1
            case .travelling:
                data = TestTopic.getTravellingTopics()
                header.text = "В путешествии"
                strela.alpha = 1
            case .add:
                print("Реклама")
                data = TestTopic.getMainTopics()
                header.text = "Наша гордость"
                strela.alpha = 0
            }
        }
    }
    
    //
    weak var delegateForPassingTest  : CellDelegateForSendingTest?
    
    let cellID = "cellIDMiddle"
    
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
        return view
    }()
    
    let strela : UIImageView = {
        let image = UIImageView(image: UIImage(named: "strela"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Тематики"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 30)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    let separatorsView : [UIView] = {
        var array : [UIView] = []
        for i in 0...3 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.init(rgb: 0xd8d8d8).withAlphaComponent(0.6)
            array.append(view)
        }
        return array
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupCV()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCV(){
        addSubview(cv)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(MainSmallCell.self, forCellWithReuseIdentifier: cellID)
        cv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        cv.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        cv.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 5).isActive = true
        cv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        for i in 0...3 {
            addSubview(separatorsView[i])
            separatorsView[i].leadingAnchor.constraint(equalTo: cv.leadingAnchor, constant: 90).isActive = true
            separatorsView[i].heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            separatorsView[i].trailingAnchor.constraint(equalTo: cv.trailingAnchor, constant: 0).isActive = true
        }
        
        separatorsView[0].topAnchor.constraint(equalTo: cv.topAnchor, constant: 86).isActive = true
        
        separatorsView[1].topAnchor.constraint(equalTo: separatorsView[0].bottomAnchor, constant: 86).isActive = true
        separatorsView[2].topAnchor.constraint(equalTo: separatorsView[1].bottomAnchor, constant: 86).isActive = true
        separatorsView[3].bottomAnchor.constraint(equalTo: cv.bottomAnchor, constant: -86.25).isActive = true
        
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
        separator1.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        view.addSubview(separator2)
        separator2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator2.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator2.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator2.topAnchor.constraint(equalTo: topAnchor).isActive = true
 
        view.addSubview(header)
        header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        
        view.addSubview(strela)
        strela.heightAnchor.constraint(equalToConstant: 12).isActive = true
        strela.widthAnchor.constraint(equalToConstant: 8).isActive = true
        strela.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -10).isActive = true
        strela.leadingAnchor.constraint(equalTo: header.trailingAnchor, constant: 12).isActive = true
    }
}

extension TopicsMiddleCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MainSmallCell
        cell.data = data[indexPath.row]
        cell.setupData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width , height: 86)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        delegateForPassingTest?.didTapLayerButton(tap: data[indexPath.row])
    }
    
}

