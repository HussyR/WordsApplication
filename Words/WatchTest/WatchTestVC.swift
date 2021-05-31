//
//  WatchTestVC.swift
//  Words
//
//  Created by Danil on 16/07/2019.
//  Copyright © 2019 Danil. All rights reserved.
//

import UIKit

class WatchTestVC: UIViewController, CellDelegate {

    var currentTest : TestTopic?
    var beginIndex = 0
    var readyForChoose = false
    var data = [Word]()
    var header = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MainTestVC
        vc.testHeader = currentTest!.header
        vc.data = data
    }
    
    func didTapLayerButton(tap: String) {
        
        if tap == "inf" {
            performSegue(withIdentifier: "segue", sender: self)
        }
        
        if tap == "tapButton" {
            readyForChoose = true
            let cell = mainCV.cellForItem(at: IndexPath(row: 1, section: 0)) as! WordsCell
            cell.tableView.allowsSelection = true
            return
        }
        
        if readyForChoose {
            let index = Int(tap)
            beginIndex = index!
            data = []
            for i in beginIndex..<currentTest!.countOfWords {
                data.append(currentTest!.wordsArray[i])
            }
            performSegue(withIdentifier: "segue", sender: self)
        }
        
    }
    
    let cellID1 = "cellID1"
    let cellID2 = "cellID2"
    
    let mainCV : UICollectionView = {
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
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = false
        setupMainCV()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBarController?.tabBar.isHidden = false
    }
    
    
    
    private func setupMainCV() {
        view.addSubview(mainCV)
        mainCV.delegate = self
        mainCV.dataSource = self
        mainCV.backgroundColor = UIColor.secondWhite()
        mainCV.register(TopWatchCell.self, forCellWithReuseIdentifier: cellID1)
        mainCV.register(WordsCell.self, forCellWithReuseIdentifier: cellID2)
        mainCV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainCV.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        mainCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}


extension WatchTestVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! TopWatchCell
            cell.delegate = self
            cell.test = currentTest
            cell.setupData()
            return cell
        }
        if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! WordsCell
            cell.delegate = self
            
            if header == "Глаголы" || header == "Существительные" || header == "Прилагательные" || header == "Silver Words" {
                cell.words = data
            } else {
                cell.words = currentTest!.wordsArray
            }
            cell.setupData()
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: view.bounds.width , height: 270)
        }
        if indexPath.row == 1 {
            var height = CGFloat(currentTest!.countOfWords * 40)
            if header == "Глаголы" || header == "Существительные" || header == "Прилагательные" || header == "Silver Words" {
                height = 400
            }
            let width = view.bounds.width
            print(height)
            return CGSize(width: width , height: height)
        }
        return CGSize(width: view.bounds.width , height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

