//
//  OtherModesVC.swift
//  Words
//
//  Created by Danil on 17/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class OtherModesVC: UIViewController {
    
    var test : TestTopic?
    
    let cellID = "CellID"
    
    var titleforNav = ""
    var data = [TestTopic]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WatchTestVC
        vc.currentTest = test!
    }
    
    let cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleforNav
        setupCV()
    }
    
    private func setupCV(){
        view.addSubview(cv)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .secondWhite()
        cv.register(OtherSmallCell.self, forCellWithReuseIdentifier: cellID)
        cv.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cv.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        cv.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    public func setupData() {
        
    }
}

extension OtherModesVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OtherSmallCell
        cell.data = data[indexPath.row]
        cell.setupData()
        if indexPath.row == data.count - 1 {
            cell.separator.alpha = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width , height: 86)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        test = data[indexPath.row]
        performSegue(withIdentifier: "segue", sender: self)
    }
    
}
