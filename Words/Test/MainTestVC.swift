//
//  MainTestVC.swift
//  Words


import UIKit

class MainTestVC: UIViewController, TestDelegate, SayDelegate {
    
    func say(phrase: String) {
        speaker.say(phrase)
    }
    
    let navView : NaVView = {
        let view = NaVView()
        return view
    }()
    
    var testHeader = ""
    var maxIndex = 0
    var speaker = TalkingService()
    
    var currentNumber = 1 {
        didSet {
            if currentNumber == 51 {
                currentNumber = 1
            }
        }
    } // Для отслеживания текущего номера задания
    
    func didTapButton(tap: TestActions, indexPath: Int) {
        
        if indexPath == maxIndex {
            navigationController?.popViewController(animated: true)
            return
        } else if indexPath % 51 == 50 {
            
            cv.scrollToItem(at: IndexPath(row: indexPath + 1, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        if indexPath == maxIndex - 1 {
            print("It's end")
            if testHeader == "Silver Words" {
                silverIndex += 1
                setIndex(type: .silverIndex)
                cv.scrollToItem(at: IndexPath(row: indexPath + 1, section: 0), at: .centeredHorizontally, animated: true)
            } else {
                cv.scrollToItem(at: IndexPath(row: indexPath + 1, section: 0), at: .centeredHorizontally, animated: true)
            }
            return
        }
        cv.scrollToItem(at: IndexPath(row: indexPath + 1, section: 0), at: .centeredHorizontally, animated: true)
    }
    

    var currentIndex = 0
    var partsOfSpeech = [0,0,0,0,0,0] // Для завершения
    var data = [Word]()
    
    let cellID1 = "cellID1"
    let cellID2 = "cellID2"
    let cellID3 = "cellID3"
    let cellID4 = "cellID4"
    let cellID5 = "cellID5"
    let cellID6 = "cellID6"
    
    let cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.isScrollEnabled = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        setupNav()
        view.backgroundColor = .mainBlue()
        print(data.count)
        print(testHeader)
        
        setupPartsOfSpeech()
        print(partsOfSpeech[0])
    }
    
    private func setupNav() {
        self.navigationItem.titleView = navView
    }
    
    private func setDefaults() {
        nouns += partsOfSpeech[0]
        verbs += partsOfSpeech[1]
        adj += partsOfSpeech[2]
        prep += partsOfSpeech[3]
        adv += partsOfSpeech[4]
        union += partsOfSpeech[5]
        
        setIndex(type: .noun)
        setIndex(type: .verb)
        setIndex(type: .adj)
        setIndex(type: .adv)
        setIndex(type: .prep)
        setIndex(type: .union)
    }
    
    private func updateArray () {
        setDefaults()
        for i in 0...5 {
            partsOfSpeech[i] = 0
        }
        currentIndex += 1
        setupPartsOfSpeech()
    }
    
    private func setupPartsOfSpeech() {
        if data.count < 11 {
            for i in 0..<data.count {
                switch data[i].partOfSpeeach {
                case "n", "noun":
                    partsOfSpeech[0] += 1
                case "v", "verb":
                    partsOfSpeech[1] += 1
                case "adj":
                    partsOfSpeech[2] += 1
                case "adv":
                    partsOfSpeech[4] += 1
                case "u", "union":
                    partsOfSpeech[5] += 1
                case "prep":
                    partsOfSpeech[3] += 1
                default:
                    break
                }
            }
        } else {
            if currentIndex * 10 + 10 > data.count {
                for i in currentIndex * 10..<data.count {
                    switch data[i].partOfSpeeach {
                    case "n", "noun":
                        partsOfSpeech[0] += 1
                    case "v", "verb":
                        partsOfSpeech[1] += 1
                    case "adj":
                        partsOfSpeech[2] += 1
                    case "adv":
                        partsOfSpeech[4] += 1
                    case "u", "union":
                        partsOfSpeech[5] += 1
                    case "prep":
                        partsOfSpeech[3] += 1
                    default:
                        break
                    }
                }
            } else {
                for i in (currentIndex) * 10..<(currentIndex + 1) * 10 {
                    switch data[i].partOfSpeeach {
                    case "n", "noun":
                        partsOfSpeech[0] += 1
                    case "v", "verb":
                        partsOfSpeech[1] += 1
                    case "adj":
                        partsOfSpeech[2] += 1
                    case "adv":
                        partsOfSpeech[4] += 1
                    case "u", "union":
                        partsOfSpeech[5] += 1
                    case "prep":
                        partsOfSpeech[3] += 1
                    default:
                        break
                    }
                
                }
            }
        }
    }
    
    
    private func setupUI() {
        view.addSubview(cv)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .green
        cv.register(AboutWordCell.self, forCellWithReuseIdentifier: cellID1)
        cv.register(AudioCell.self, forCellWithReuseIdentifier: cellID2)
        cv.register(LettersCell.self, forCellWithReuseIdentifier: cellID3)
        cv.register(TranslateInRUCell.self, forCellWithReuseIdentifier: cellID4)
        cv.register(TranslateInENGCell.self, forCellWithReuseIdentifier: cellID5)
        cv.register(FinalCell.self, forCellWithReuseIdentifier: cellID6)
        cv.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cv.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        cv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setup() {
        navigationController?.navigationBar.barTintColor = .mainBlue()
        navigationController?.navigationBar.barStyle = .black
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupCell (mode: UICollectionViewCell, number: Int) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

extension MainTestVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var value = data.count
        value %= 10
        var returnValue = 0
        
        if data.count > 9 {
            returnValue = (data.count / 10) * 51
            if data.count > 10 {
                returnValue += 1
            }
        } else {
            returnValue += 1
        }
        
        switch value {
        case 1:
            returnValue += 1
        case 2:
            returnValue += 4
        case 3:
            returnValue += 8
        case 4:
            returnValue += 13
        case 5:
            returnValue += 18
        case 6:
            returnValue += 21
        case 7:
            returnValue += 26
        case 8:
            returnValue += 33
        case 9:
            returnValue += 42
        default:
            break
        }
        print(returnValue)
        maxIndex = returnValue - 1 // С учетом indexPath.row
        print("maxindex is \(maxIndex)")
        return returnValue
        // 1 - 1
        // 2 - 4
        // 3 - 8
        // 4 - 13
        // 5 - 18
        // 6 - 21
        // 7 - 26
        // 8 - 33
        // 9 - 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if data.count < 10 {
            if indexPath.row == maxIndex {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID6, for: indexPath) as! FinalCell
                cell.testDelegate = self
                cell.maxCount = data.count
                cell.indexPath = indexPath.row
                cell.counts = partsOfSpeech
                cell.setupNeed()
                print("Обновляю дефолты")
                setDefaults()
                return cell
            }
        } else {
            if indexPath.row == maxIndex {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID6, for: indexPath) as! FinalCell
                cell.testDelegate = self
                cell.maxCount = data.count == 10 ? 10 : data.count % 10
                cell.indexPath = indexPath.row
                cell.counts = partsOfSpeech
                cell.setupNeed()
                print("Обновляю дефолты")
                setDefaults()
                return cell
            } else if indexPath.row > 49 && indexPath.row % 51 == 50 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID6, for: indexPath) as! FinalCell
                cell.testDelegate = self
                cell.maxCount = 10
                cell.indexPath = indexPath.row
                cell.counts = partsOfSpeech
                cell.setupNeed()
                print("Обновляю дефолты")
                updateArray()
                return cell
            }
        }
        print(101 % 51)
        let plus = (indexPath.row / 51) * 10
        print("plus is \(plus)")
        switch indexPath.row % 51 {
        case 0,1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! AboutWordCell
            cell.testDelegate =  self
            if indexPath.row > 50 {
                cell.word = data[indexPath.row % 10 + plus - (indexPath.row / 50)]
            } else {
                cell.word = data[indexPath.row % 10 + plus]
                navView.currentProgress = Double(currentNumber) / Double(maxIndex >= 50 ? 50 : maxIndex)
            }
            cell.sayDelegate = self
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! TranslateInENGCell
            cell.testDelegate =  self
            cell.word = data[0 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AudioCell
            cell.testDelegate =  self
            cell.word = data[1 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! AboutWordCell
            cell.testDelegate =  self
            cell.word = data[2 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! LettersCell
            cell.testDelegate =  self
            cell.deleteOldUI()
            cell.word = data[0 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TranslateInRUCell
            cell.testDelegate =  self
            cell.word = data[1 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 7:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! TranslateInENGCell
            cell.testDelegate =  self
            print(data[2].word)
            cell.word = data[2 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 8:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! AboutWordCell
            cell.testDelegate =  self
            cell.word = data[3 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 9:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! LettersCell
            cell.testDelegate =  self
            cell.deleteOldUI()
            cell.word = data[2 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 10:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TranslateInRUCell
            cell.testDelegate =  self
            cell.word = data[0 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 11:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! TranslateInENGCell
            cell.testDelegate =  self
            cell.word = data[3 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 12:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TranslateInRUCell
            cell.testDelegate =  self
            cell.word = data[2 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 13:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! AboutWordCell
            cell.testDelegate =  self
            cell.word = data[4 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 14:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AudioCell
            cell.testDelegate =  self
            cell.word = data[2 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 15:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! LettersCell
            cell.testDelegate =  self
            cell.deleteOldUI()
            cell.word = data[1 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 16:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TranslateInRUCell
            cell.testDelegate =  self
            cell.word = data[4 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 17:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! LettersCell
            cell.testDelegate =  self
            cell.deleteOldUI()
            cell.word = data[3 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 18:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! AboutWordCell
            cell.testDelegate =  self
            cell.word = data[5 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 19:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AudioCell
            cell.testDelegate =  self
            cell.word = data[4 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 20:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TranslateInRUCell
            cell.testDelegate =  self
            cell.word = data[5 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 21:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! AboutWordCell
            cell.testDelegate =  self
            cell.word = data[6 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 22:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! TranslateInENGCell
            cell.testDelegate =  self
            cell.word = data[1 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 23:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AudioCell
            cell.testDelegate =  self
            cell.word = data[0 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 24:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TranslateInRUCell
            cell.testDelegate =  self
            cell.word = data[3 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 25:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! TranslateInENGCell
            cell.testDelegate =  self
            cell.word = data[6 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 26:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! AboutWordCell
            cell.testDelegate =  self
            cell.word = data[7 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 27:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! LettersCell
            cell.testDelegate =  self
            cell.deleteOldUI()
            cell.word = data[5 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 28:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AudioCell
            cell.testDelegate =  self
            cell.word = data[6 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 29:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TranslateInRUCell
            cell.testDelegate =  self
            cell.word = data[7 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 30:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TranslateInRUCell
            cell.testDelegate =  self
            cell.word = data[6 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 31:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AudioCell
            cell.testDelegate =  self
            cell.word = data[3 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 32:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! LettersCell
            cell.testDelegate =  self
            cell.deleteOldUI()
            cell.word = data[7 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 33:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! AboutWordCell
            cell.testDelegate =  self
            cell.word = data[8 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 34:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AudioCell
            cell.testDelegate =  self
            cell.word = data[5 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 35:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! TranslateInENGCell
            cell.testDelegate =  self
            cell.word = data[8 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 36:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! TranslateInENGCell
            cell.testDelegate =  self
            cell.word = data[7 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 37:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! LettersCell
            cell.testDelegate =  self
            cell.deleteOldUI()
            cell.word = data[4 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 38:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! TranslateInENGCell
            cell.testDelegate =  self
            cell.word = data[5 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 39:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AudioCell
            cell.testDelegate =  self
            cell.word = data[8 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 40:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! TranslateInENGCell
            cell.testDelegate =  self
            cell.word = data[4 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 41:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! LettersCell
            cell.testDelegate =  self
            cell.deleteOldUI()
            cell.word = data[8 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 42:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID1, for: indexPath) as! AboutWordCell
            cell.testDelegate =  self
            cell.word = data[9 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 43:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AudioCell
            cell.testDelegate =  self
            cell.word = data[7 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 44:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TranslateInRUCell
            cell.testDelegate =  self
            cell.word = data[9 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 45:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! LettersCell
            cell.testDelegate =  self
            cell.deleteOldUI()
            cell.word = data[6 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 46:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AudioCell
            cell.testDelegate =  self
            cell.word = data[9 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 47:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID5, for: indexPath) as! TranslateInENGCell
            cell.testDelegate =  self
            cell.word = data[9 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 48:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID4, for: indexPath) as! TranslateInRUCell
            cell.testDelegate =  self
            cell.word = data[8 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        case 49:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID3, for: indexPath) as! LettersCell
            cell.testDelegate =  self
            cell.deleteOldUI()
            cell.word = data[9 + plus]
            cell.setupNeededWord(indexPath: indexPath.row)
            return cell
        default: break
        }
        print(indexPath.row % 51)
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let p = view.safeAreaInsets.bottom + view.safeAreaInsets.top
        return CGSize(width: view.bounds.width , height: view.bounds.height - p)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cv.cellForItem(at: IndexPath(row: indexPath.row + 1, section: 0))
        
        if cell is FinalCell {
            
        } else {
            currentNumber += 1
        }
        
        print("current number is \(currentNumber)")
        
        
        
        let percent : Double = Double(currentNumber) / Double(maxIndex >= 50 ? 50 : maxIndex)
        print("percent is \(percent)")
        navView.currentProgress = percent                                                               // В кастом классе
        
        print(indexPath.row)
        
        
        if cell is AudioCell {
            let cell2 = cv.cellForItem(at: IndexPath(row: indexPath.row + 1, section: 0)) as! AudioCell
            cell2.sayWord()
        }
        
        if cell is AboutWordCell {
            switch testHeader {
            case "Глаголы":
                infVerbsIndex += 1
                setIndex(type: .infVerbsIndex)
            case "Прилагательные":
                infAdjIndex += 1
                setIndex(type: .infAdjIndex)
            case "Существительные":
                infNounsIndex += 1
                setIndex(type: .infNounsIndex)
            default:
                break
            }
            
            print("Verbs \(infVerbsIndex)")
            print("Nouns \(infNounsIndex)")
            print("Adj \(infAdjIndex)")
            
            let cell2 = cv.cellForItem(at: IndexPath(row: indexPath.row + 1, section: 0)) as! AboutWordCell
            cell2.sayWord()
        }
    }
}
