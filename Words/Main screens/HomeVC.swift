//
//  HomeVC.swift
//  Words


import UIKit

class HomeVC: UIViewController, CellDelegateForSendingTest, CellDelegate {
    
    let data = TestTopic.getTopicsForHomeScroll()
    
    func didTapLayerButton(tap: TestTopic) {
        self.test = tap
        print("Устанавливаю тест")
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    func didTapLayerButton(tap: String) {
        let alert = UIAlertController(title: "Ежедневные тесты", message: "Чтобы открыть следующий тест, пройдите текущий", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    
    let cellID1 = "cellID1"
    let cellID2 = "cellID2"
    let cellID3 = "cellID3"
    let cellID4 = "cellID4"
    
    var test : TestTopic?
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if test!.header == "Silver Words" {
            var passData = [Word]()
            for i in 0...9 {
                passData.append(test!.wordsArray[silverIndex * 10 + i])
            }
            let vc = segue.destination as! WatchTestVC
            vc.data = passData
            vc.header = test!.header
            vc.currentTest = test
            
        } else {
        let vc = segue.destination as! WatchTestVC
        vc.currentTest = test
        print("Передаю тест")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupMainCV()
        print("viewdidload")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setupMainCV() {
        view.addSubview(mainCV)
        mainCV.delegate = self
        mainCV.dataSource = self
        mainCV.backgroundColor = UIColor.init(white: 0.975, alpha: 1)
        mainCV.register(TopFavoriteCell.self, forCellWithReuseIdentifier: cellID1)
        mainCV.register(SilverCell.self, forCellWithReuseIdentifier: cellID2)
        mainCV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID3)
        mainCV.register(GoldCell.self, forCellWithReuseIdentifier: cellID4)
        mainCV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainCV.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        mainCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.mainBlue()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
}


extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath)
            cell.backgroundColor = .clear
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! TopFavoriteCell
            cell.delegate = self
            return cell
        }
        if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath)
            cell.backgroundColor = .clear
            return cell
        }
        if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! SilverCell
            cell.alertDelegate = self
            cell.delegate = self
            return cell
        }
        if indexPath.row == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! GoldCell
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: view.bounds.width , height: 6)
        }
        if indexPath.row == 1 {
            return CGSize(width: view.bounds.width , height: 122)
        }
        if indexPath.row == 2 {
            return CGSize(width: view.bounds.width , height: 6)
        }
        if indexPath.row == 3 {
            return CGSize(width: view.bounds.width , height: 288)
        }
        if indexPath.row == 4 {
            return CGSize(width: view.bounds.width , height: 260)
        }
        return CGSize(width: view.bounds.width , height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
}


