
//
//  ProfileVC.swift
//  Words


import UIKit

class ProfileVC: UIViewController, CellDelegate {
    
    var ip  = UIImagePickerController()
    
    func didTapLayerButton(tap: String) {
        
        if tap == "alertProgress" {
            let alert = UIAlertController(title: "Прогресс", message: "Пройдите тест до завершающего экрана, чтобы увеличить прогресс", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .cancel))
            present(alert, animated: true, completion: nil)
            return
        } else if tap == "alertDiagram" {
            let alert = UIAlertController(title: "Пройденные слова", message: "Пройдите тест до завершающего экрана, чтобы пройти слова", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .cancel))
            present(alert, animated: true, completion: nil)
            return
        }
        
        ip.sourceType = .photoLibrary
        ip.allowsEditing = true
        present(ip, animated: true, completion: nil)
    }
    
    let cellID1 = "cellID1"
    let cellID2 = "cellID2"
    let cellID3 = "cellID3"
    let cellID4 = "cellID4"
    
    var isLoad = false
    
    let mainCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isLoad {
            let cell = mainCV.cellForItem(at: IndexPath(row: 4, section: 0)) as? DiagramProfileCell
            if cell != nil {
                cell!.setupCustom()
            }
            let cell2 = mainCV.cellForItem(at: IndexPath(row: 0, section: 0)) as? ProfileCell
            if cell2 != nil {
                cell2!.countOfWords1.text = String(learnWords)
                cell2!.countOfWords2.text = String(verbs)
                cell2!.getRank()
            }
            let cell3 = mainCV.cellForItem(at: IndexPath(row: 2, section: 0)) as? ProgressCell
            if cell3 != nil {
                cell3!.getProgress()
                cell3!.getRank()
            }
        }
        isLoad = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let cell = mainCV.cellForItem(at: IndexPath(row: 4, section: 0)) as? DiagramProfileCell
        if cell != nil {
            cell!.updataCustom()
        }
        let cell2 = mainCV.cellForItem(at: IndexPath(row: 2, section: 0)) as? ProgressCell
        if cell2 != nil {
            cell2!.circle.strokeEnd = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupMainCV()
        ip.delegate = self
    }
    
    private func setupMainCV() {
        view.addSubview(mainCV)
        mainCV.delegate = self
        mainCV.dataSource = self
        mainCV.backgroundColor = UIColor.secondWhite()
        mainCV.register(ProfileCell.self, forCellWithReuseIdentifier: cellID1)
        mainCV.register(ProgressCell.self, forCellWithReuseIdentifier: cellID3)
        mainCV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID2)
        mainCV.register(DiagramProfileCell.self, forCellWithReuseIdentifier: cellID4)
        mainCV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainCV.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        mainCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.mainBlue()
        navigationController?.navigationBar.barStyle = .black
    }
    
    
}


extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! ProfileCell
            cell.delegate = self
            return cell
        }
        if indexPath.row == 1 || indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath)
            cell.backgroundColor = .clear
            return cell
        }
        if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! ProgressCell
            cell.delegate = self
            return cell
        }
        if indexPath.row == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! DiagramProfileCell
            cell.delegate = self
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: view.bounds.width , height: 170)
        }
        if indexPath.row == 1 {
            return CGSize(width: view.bounds.width , height: 6)
        }
        if indexPath.row == 2 {
            return CGSize(width: view.bounds.width , height: 435)
        }
        if indexPath.row == 4 {
            return CGSize(width: view.bounds.width , height: 535)
        }
        if indexPath.row == 3 {
            return CGSize(width: view.bounds.width , height: 6)
        }
        
        return CGSize(width: view.bounds.width , height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension ProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image2 = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let cell = mainCV.cellForItem(at: IndexPath(row: 0, section: 0)) as! ProfileCell
            let cell2 = mainCV.cellForItem(at: IndexPath(row: 2, section: 0)) as! ProgressCell
            cell.image = image2
            cell2.image = image2
            defaults.set(image2.pngData(), forKey: KeysForDefaults.avatarData)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
