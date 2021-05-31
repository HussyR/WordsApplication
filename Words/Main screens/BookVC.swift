//
//  BookVC.swift
//  Words

import UIKit

class BookVC: UIViewController, CellDelegate, CellDelegateForSendingTest {
    enum OtherTestVariants {
        case begin
        case topics
        case travelling
        case nothing
    }
    
    var firstScroll = false
    var secondscroll = false
    var testSend : OtherTestVariants = .nothing
    
    func didTapLayerButton(tap: TestTopic) {
        test = tap
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    var test : TestTopic?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue2" && testSend == .begin {
            let vc = segue.destination as! OtherModesVC
            vc.data = TestTopic.getTopicsForBeginners()
            vc.titleforNav = "Для начинающих"
            return
        }
        if segue.identifier == "segue2" && testSend == .topics {
            let vc = segue.destination as! OtherModesVC
            vc.data = TestTopic.getMainTopics()
            vc.titleforNav = "Тематики"
            return
        }
        if segue.identifier == "segue2" && testSend == .travelling {
            let vc = segue.destination as! OtherModesVC
            vc.data = TestTopic.getTravellingTopics()
            vc.titleforNav = "В путешествии"
            return
        }
        
        if segue.identifier == "segue1" {
            let vc = segue.destination as! WatchTestVC
            if test!.header == "Глаголы" || test!.header == "Существительные" || test!.header == "Прилагательные" {
                var data = [Word]()
                setupTest(array: &data)
                vc.data = data
                vc.header = test!.header
                vc.currentTest = test
            } else {
                vc.currentTest = test
            }
        }
    }
    
    private func setupTest(array : inout [Word]) {
        switch test!.header {
        case "Глаголы":
            for i in 0...9 {
                array.append(test!.wordsArray[infVerbsIndex + i])
            }
        case "Прилагательные":
            for i in 0...9 {
                array.append(test!.wordsArray[infAdjIndex + i])
            }
        case "Существительные":
            for i in 0...9 {
                array.append(test!.wordsArray[infNounsIndex + i])
            }
        default:
            break
        }
        
    }
    
    func didTapLayerButton(tap: String) {
        
        switch tap {
        case "Темы":
            testSend = .topics
            //isBeginners = false
            performSegue(withIdentifier: "segue2", sender: self)
        case "Начинающие":
            testSend = .begin
            //isBeginners = true
            performSegue(withIdentifier: "segue2", sender: self)
        case "Путешествия":
            testSend = .travelling
            //isBeginners = true
            performSegue(withIdentifier: "segue2", sender: self)
        default:
            break
        }
    }
    
    let cellID = "cell"
    
    let firstCellID = "cell3"
    let secondcellID = "cell4"
    
    let scrollView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    var horizontalBarConstraint: NSLayoutConstraint?
    
    private func setupCV(){
        view.addSubview(cv)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.init(rgb: 0x5C7EE4)
        cv.register(CellWithText.self, forCellWithReuseIdentifier: cellID)
        cv.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cv.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cv.heightAnchor.constraint(equalToConstant: 42).isActive = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        view.addSubview(scrollView)
        scrollView.bottomAnchor.constraint(equalTo: cv.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.bounds.width / 2).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        horizontalBarConstraint = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        horizontalBarConstraint?.isActive = true
        horizontalBarConstraint?.constant = 0
        
    }
    
    let mainCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCV()
        setupMainCV()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !firstScroll {
        firstScroll = true
        let cell = mainCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as! TopicsCell
        let cell2 = cell.mainCV.cellForItem(at: IndexPath(row: 0, section: 0)) as! TopScrollMiddleCell
        cell2.topScrollCV.scrollToItem(at: IndexPath(row: 48, section: 0), at: .centeredHorizontally, animated: false)
        }
        
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.mainBlue()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupMainCV () {
        view.addSubview(mainCollectionView)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.backgroundColor = UIColor.green
        mainCollectionView.register(TopicsCell.self, forCellWithReuseIdentifier: firstCellID)
        mainCollectionView.register(PartsOfSpeechCell.self, forCellWithReuseIdentifier: secondcellID)
        mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainCollectionView.topAnchor.constraint(equalTo: cv.bottomAnchor, constant: 0).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension BookVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cv {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CellWithText
            cell.text.text = (indexPath.row == 0 ? "Темы" : "Части речи")
            return cell
        }
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellID, for: indexPath) as! TopicsCell
            cell.delegate = self
            cell.delegateForPassingTest = self
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondcellID, for: indexPath) as! PartsOfSpeechCell
        cell.delegateForPassingTest = self
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == cv {
            return CGSize(width: view.bounds.width / 2, height: 42)
        }
        let inset = view.safeAreaInsets.bottom + view.safeAreaInsets.top + 42
        return CGSize(width: view.bounds.width, height: view.bounds.height - inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cv {
            
            print("Tap on top Cell")
            mainCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            let x = CGFloat(indexPath.row) * view.frame.width * 0.5
            horizontalBarConstraint?.constant = x
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        } else {
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == mainCollectionView {
            if indexPath.row == 0 {
                if !secondscroll {
                    let cell3 = mainCollectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as! PartsOfSpeechCell
                    let cell4 = cell3.mainCV.cellForItem(at: IndexPath(row: 0, section: 0)) as! TopScrollMiddleCell
                    cell4.topScrollCV.scrollToItem(at: IndexPath(row: 48, section: 0), at: .centeredHorizontally, animated: false)
                    secondscroll = true
                }
            }
        }
    }
    
}
