//
//  VerbsModesCell.swift
//  Words


import UIKit

class VerbsModesCell: UICollectionViewCell {
    
    weak var delagate : CellDelegateForSendingTest?
    
    let data = TestTopic.getPhrasalVerbs()
    let cellID = "cellID"
    let colorData : [UIColor] = [UIColor.init(rgb: 0xFFE263),
                                 UIColor.init(rgb: 0x576DDC),
                                 UIColor.init(rgb: 0x4C90F9).withAlphaComponent(0.8),
                                 UIColor.init(rgb: 0xFF7058),
                                 UIColor.init(rgb: 0x885AD8),
                                 UIColor.init(rgb: 0x14C966),
                                 UIColor.init(rgb: 0xF94C7B),
                                 UIColor.init(rgb: 0xFFE263)]
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
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
    
    let header : UILabel = {
        let label = UILabel()
        label.text = "Фразовые глаголы"
        label.font = UIFont(name: "SourceSansPro-Regular", size: 30)
        label.textColor = UIColor(white: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 25
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
        
        view.addSubview(separator2)
        separator2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator2.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator2.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator2.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        view.addSubview(header)
        header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        
        view.addSubview(cv)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.white
        cv.register(VerbsBannerCell.self, forCellWithReuseIdentifier: cellID)
        cv.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cv.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 0).isActive = true
        cv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        
        view.addSubview(separator1)
        separator1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separator1.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separator1.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator1.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
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


extension VerbsModesCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! VerbsBannerCell
        cell.data = data[indexPath.row]
        cell.setupData()
        cell.backgroundColor = colorData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 260 , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delagate?.didTapLayerButton(tap: data[indexPath.row])
    }
    

}
