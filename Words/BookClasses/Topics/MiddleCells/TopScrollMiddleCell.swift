//
//  TopScrollMiddleCell.swift
//  Words


import UIKit

class TopScrollMiddleCell: UICollectionViewCell {
    
    weak var delegateForPassingTest  : CellDelegateForSendingTest?
    var colorsData = [UIColor]()
    var data = [TestTopic]()
    var isTopics : Bool = true
    
    let topScrollCellID = "topScrollCellID"

    let topScrollCV : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    private func setupTopScrollCV(){
        addSubview(topScrollCV)
        topScrollCV.delegate = self
        topScrollCV.dataSource = self
        topScrollCV.backgroundColor = .clear
        topScrollCV.register(TopScrollCell.self, forCellWithReuseIdentifier: topScrollCellID)
        topScrollCV.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topScrollCV.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topScrollCV.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topScrollCV.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        topScrollCV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupMood(_ isTopic:Bool) {
        switch isTopic {
        case true:
            colorsData = [UIColor.init(rgb: 0xF0C074), UIColor.init(rgb: 0xFFE99D),
                          UIColor.init(rgb: 0x3A8D5C), UIColor.init(rgb: 0x33C36F),
                          UIColor.init(rgb: 0xD4BFAA), UIColor.init(rgb: 0xFFE7CF),
                          UIColor.init(rgb: 0xC23A3A), UIColor.init(rgb: 0xD55151)]
            data = TestTopic.getTopicsForBookScroll()
            isTopics = true
            setupTopScrollCV()
        case false:
            data = TestTopic.getTopicsForParts()
            colorsData = [UIColor.init(rgb: 0xFFC281), UIColor.init(rgb: 0xFFE99D),
                          UIColor.init(rgb: 0x64C8F6), UIColor.init(rgb: 0xBEF6FF),
                          UIColor.init(rgb: 0x61BFDC), UIColor.init(rgb: 0xA8E7F3),
                          UIColor.init(rgb: 0x30CF4E), UIColor.init(rgb: 0x49FF55),
                          UIColor.init(rgb: 0xBB3D4A), UIColor.init(rgb: 0xDC5E62),
                          UIColor.init(rgb: 0xB6463B), UIColor.init(rgb: 0xEB6659)]
            isTopics = false
            setupTopScrollCV()
            
        }
    }
    
    private func setup(){
        
    }
    
}

extension TopScrollMiddleCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isTopics {
            return 200
        } else {
            return 200
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topScrollCellID, for: indexPath) as! TopScrollCell
        cell.data = data[indexPath.row % data.count]
        cell.setupData()
        switch indexPath.row % data.count {
        case 0:
            cell.setupGradient(color1: colorsData[0], color2: colorsData[1])
        case 1:
            cell.setupGradient(color1: colorsData[2], color2: colorsData[3])
        case 2:
            cell.setupGradient(color1: colorsData[4], color2: colorsData[5])
        case 3:
            cell.setupGradient(color1: colorsData[6], color2: colorsData[7])
        case 4:
            cell.setupGradient(color1: colorsData[8], color2: colorsData[9])
        case 5:
            cell.setupGradient(color1: colorsData[10], color2: colorsData[11])
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width , height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row % data.count)
        var image = ""
        
        if data.count == 6 {
            switch indexPath.row % data.count {
            case 0:
                image = "WatchDiamond1"
            case 1:
                image = "WatchDiamond2"
            case 2:
                image = "WatchDiamond3"
            case 3:
                image = "WatchDiamond4"
            case 4:
                image = "WatchDiamond5"
            case 5:
                image = "WatchDiamond6"
            default:
                break
            }
        } else {
        switch indexPath.row % data.count {
        case 0:
            image = "WatchFood"
        case 1:
            image = "WatchTravelling"
        case 2:
            image = "WatchDoctor"
        case 3:
            image = "WatchSweater"
        default:
            break
        }
        }
        let test = data[indexPath.row % data.count]
        delegateForPassingTest?.didTapLayerButton(tap: TestTopic(image: image, header: test.header, countOfWords: test.countOfWords, array: test.wordsArray, watchImage: image))
    }
    
}
