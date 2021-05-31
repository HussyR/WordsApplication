//
//  Model.swift
//  Words


import UIKit
import AVFoundation

struct UserLevels {
    static let student : Double = 300
    static let znatok : Double  = 600
    static let master : Double  = 1000
    static let professionsal : Double  = 3000
    static let native : Double  = 5000
}

// DEFAULTS
struct KeysForDefaults {
    static let infVerbsIndex = "infVerbsIndex"
    static let infNounsIndex = "infNounsIndex"
    static let infAdjIndex = "infAdjIndex"
    static let silverIndex = "silverIndex"
    static let isLogin = "isLogin"
    static let userName = "userName"
    
    static let noun = "nouns"
    static let verb = "verb"
    static let adj = "adj"
    static let adv = "adv"
    static let union = "union"
    static let prep = "prep"
    static let avatarData = "avatarData"
}

enum TypesDefaults {
    case isLogin
    case infVerbsIndex
    case infNounsIndex
    case infAdjIndex
    case silverIndex
    case userName
    case noun
    case verb
    case adj
    case adv
    case union
    case prep
    case avatarData
}

let defaults = UserDefaults.standard

var userName = ""
var isLogin = false
var infVerbsIndex = 0 {
    didSet {
        if infVerbsIndex > 190 { // <--------- FIXME:
            infVerbsIndex = 0
        }
    }
}
var infNounsIndex = 0 {
    didSet {
        if infNounsIndex > 190 { // <--------- FIXME:
            infNounsIndex = 0
        }
    }
}
var infAdjIndex = 0 {
    didSet {
        if infAdjIndex > 190 { // <--------- FIXME:
            infAdjIndex = 0
        }
    }
}
var silverIndex = 0 {
    didSet {
        if silverIndex > 9 { // <--------- FIXME:
            silverIndex = 0
        }
    }
}

var learnWords : Int {
    return nouns + verbs + adj + adv + prep + union
}

var nouns = 0
var verbs = 0
var adj = 0
var adv = 0
var union = 0
var prep = 0


func setupDefaults() {
    defaults.register(defaults: ["avatarData":UIImage(named: "GreatPlus")!.pngData()!])
    isLogin = defaults.bool(forKey: KeysForDefaults.isLogin)
    infVerbsIndex = defaults.integer(forKey: KeysForDefaults.infVerbsIndex)
    infNounsIndex = defaults.integer(forKey: KeysForDefaults.infNounsIndex)
    infAdjIndex = defaults.integer(forKey: KeysForDefaults.infAdjIndex)
    silverIndex = defaults.integer(forKey: KeysForDefaults.silverIndex)
    userName = defaults.value(forKey: KeysForDefaults.userName) as? String ?? ""
    nouns = defaults.integer(forKey: KeysForDefaults.noun)
    verbs = defaults.integer(forKey: KeysForDefaults.verb)
    adj = defaults.integer(forKey: KeysForDefaults.adj)
    adv = defaults.integer(forKey: KeysForDefaults.adv)
    union = defaults.integer(forKey: KeysForDefaults.union)
    prep = defaults.integer(forKey: KeysForDefaults.prep)
}

func updateDefault (type : TypesDefaults) {
    switch type {
    case .infVerbsIndex:
        defaults.set(0, forKey: KeysForDefaults.infVerbsIndex)
    case .infNounsIndex:
        defaults.set(0, forKey: KeysForDefaults.infNounsIndex)
    case .infAdjIndex:
        defaults.set(0, forKey: KeysForDefaults.infAdjIndex)
    case .silverIndex:
        defaults.set(0, forKey: KeysForDefaults.silverIndex)
    case .isLogin:
        defaults.set(false, forKey: KeysForDefaults.isLogin)
    case .userName:
        defaults.set("", forKey: KeysForDefaults.userName)
    case .noun:
        defaults.set(0, forKey: KeysForDefaults.noun)
    case .verb:
        defaults.set(0, forKey: KeysForDefaults.verb)
    case .adj:
        defaults.set(0, forKey: KeysForDefaults.adj)
    case .adv:
        defaults.set(0, forKey: KeysForDefaults.adv)
    case .union:
        defaults.set(0, forKey: KeysForDefaults.union)
    case .prep:
        defaults.set(0, forKey: KeysForDefaults.prep)
    case .avatarData:
        defaults.set(UIImage(named: "GreatPlus")!.pngData(), forKey: KeysForDefaults.avatarData)
    }
}

func setIndex(type : TypesDefaults) {
    switch type {
    case .infVerbsIndex:
        defaults.set(infVerbsIndex, forKey: KeysForDefaults.infVerbsIndex)
    case .infNounsIndex:
        defaults.set(infNounsIndex, forKey: KeysForDefaults.infNounsIndex)
    case .infAdjIndex:
        defaults.set(infAdjIndex, forKey: KeysForDefaults.infAdjIndex)
    case .silverIndex:
        defaults.set(silverIndex, forKey: KeysForDefaults.silverIndex)
    case .isLogin:
        defaults.set(isLogin, forKey: KeysForDefaults.isLogin)
    case .userName:
        defaults.set(userName, forKey: KeysForDefaults.userName)
    case .noun:
        defaults.set(nouns, forKey: KeysForDefaults.noun)
    case .verb:
        defaults.set(verbs, forKey: KeysForDefaults.verb)
    case .adj:
        defaults.set(adj, forKey: KeysForDefaults.adj)
    case .adv:
        defaults.set(adv, forKey: KeysForDefaults.adv)
    case .union:
        defaults.set(union, forKey: KeysForDefaults.union)
    case .prep:
        defaults.set(prep, forKey: KeysForDefaults.prep)
    default: break
    }
    
}
//

var silverData = [Word]()
var goldData = [Word]()

//--------------------------

// ФРАЗОВЫЕ ТЕМЫ

var goData = [Word]()
var getData = [Word]()
var giveData = [Word]()
var lookData = [Word]()
var makeData = [Word]()
var takeData = [Word]()
var bringData = [Word]()
var phrasalData = [Word]()

// -------------------

var enVariantsForNumbers = [String]()
var ruVariantsForNumbers = [String]()

// inf topics

var infVerbsData = [Word]()
var infNounsData = [Word]()
var infAdjData = [Word]()

// Top Parts Topics

var verbsData = [Word]()
var nounsData = [Word]()
var adjData = [Word]()
var advData = [Word]()
var prepData = [Word]()
var unionData = [Word]()

// Banners Topics

var spaceData = [Word]()
var cookingData = [Word]()
var engLineData = [Word]()
var eng5Data = [Word]()

// ANY WAYS TOPICS

var natureData = [Word]()
var hospitalData = [Word]()
var airPlaneData = [Word]()
var cityData = [Word]()
var hotelData = [Word]()
var detectiveData = [Word]()
var shopData = [Word]()
var schoolData = [Word]()
var travellingData = [Word]()
var judgeData = [Word]()
var weddingData = [Word]()
var interviewData = [Word]()
var restaurantData = [Word]()
var SeaAndBeachData = [Word]()
var villageData = [Word]()
//
var counriesData = [Word]()
var sportData = [Word]()
var foodData = [Word]()
var furnitureData = [Word]()
var appearanceData = [Word]()
var clothesData = [Word]()
var weatherData = [Word]()
var feelData = [Word]()
var vegetablesData = [Word]()
var animalsData = [Word]()
var professionsData = [Word]()
var colorsData = [Word]()
var petsData = [Word]()
var transportData = [Word]()
var partsOfFamilyData = [Word]()
var fruitWordsData = [Word]()
var numbersWordsData = [Word]()
var seasonsData = [Word]()

class TalkingService {
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func say(_ phrase: String){
        let u = AVSpeechUtterance(string: phrase)
        u.voice = AVSpeechSynthesisVoice(language: "en-GB")
        u.rate = 0.5
        if synthesizer.isSpeaking {
            return
        }
        synthesizer.speak(u)
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
    }
}



protocol CellDelegate: class {
    func didTapLayerButton(tap : String)
}

protocol TestDelegate: class {
    func didTapButton(tap : TestActions, indexPath: Int)
}

protocol SayDelegate: class {
    func say(phrase: String)
}

protocol CellDelegateForSendingTest: class {
    func didTapLayerButton(tap : TestTopic)
}

enum TestActions {
    case skip
    case stop
}



class TestTopic {
    let image : String
    let header : String
    let countOfWords : Int
    var wordsArray = [Word]()
    var watchImage = ""
    var author = ""
    
    init(image: String, header : String, countOfWords : Int) {
        self.image = image
        self.header = header
        self.countOfWords = countOfWords
    }
    
    init(image: String, header : String, countOfWords : Int, array : [Word]) {
        self.image = image
        self.header = header
        self.countOfWords = countOfWords
        self.wordsArray = array
    }
    
    init(image: String, header : String, countOfWords : Int, array : [Word], watchImage : String) {
        self.image = image
        self.header = header
        self.countOfWords = countOfWords
        self.wordsArray = array
        self.watchImage = watchImage
    }
    
    init(image: String, header : String, countOfWords : Int, array : [Word], watchImage : String, author : String) {
        self.image = image
        self.header = header
        self.countOfWords = countOfWords
        self.wordsArray = array
        self.watchImage = watchImage
        self.author = author
    }
    
    static func getTopicsForHomeScroll () -> [TestTopic] {
        return [TestTopic(image: "Dog", header: "Питомцы", countOfWords: 21, array: petsData, watchImage: "WatchDog"),
                TestTopic(image: "Cheese", header: "Еда", countOfWords: 48, array: foodData, watchImage: "WatchFood"),
                TestTopic(image: "Dambell", header: "Спорт", countOfWords: 47, array: sportData, watchImage: "WatchSport"),
                TestTopic(image: "Wedding2", header: "На свадьбе", countOfWords: 61, array: weddingData, watchImage: "WatchWedding"),
                TestTopic(image: "Sweater2", header: "Одежда", countOfWords: 55, array: clothesData, watchImage: "WatchSweater"),
                TestTopic(image: "RoundWeather", header: "Погода", countOfWords: 43, array: weatherData, watchImage: "WatchWeather"),
                TestTopic(image: "RoundVerbs", header: "Топ глаголов", countOfWords: 100, array: verbsData, watchImage: "WatchVerbs"),
                TestTopic(image: "RoundPilot", header: "В самолете", countOfWords: 47, array: airPlaneData, watchImage: "WatchPilot")]
    }
    
    static func getSilverAndGoldTests () -> [TestTopic] {
        return [TestTopic(image: "Happy", header: "Silver Words", countOfWords: 100, array: silverData, watchImage: "WatchAdj"),
                TestTopic(image: "Cup", header: "Gold Words", countOfWords: 100, array: goldData, watchImage: "Cup")]
    }
    
    static func getTopicsForBeginners () -> [TestTopic] {
        return [TestTopic(image: "Car", header: "Транспорт", countOfWords: 19, array: transportData, watchImage: "WatchCar"),
                TestTopic(image: "DOG1", header: "Питомцы", countOfWords: 21, array: petsData, watchImage: "WatchDog"),
                TestTopic(image: "Colors", header: "Цвета", countOfWords: 40, array: colorsData, watchImage: "WatchColors"),
                TestTopic(image: "Apple", header: "Фрукты", countOfWords: 20, array: fruitWordsData, watchImage: "WatchApples"),
                TestTopic(image: "MembersOfFamily", header: "Члены семьи", countOfWords: 21, array: partsOfFamilyData, watchImage: "WatchFamily"),
                TestTopic(image: "Numbers", header: "Числа", countOfWords: 20, array: numbersWordsData, watchImage: "WatchNumbers"),
                TestTopic(image: "Seasons", header: "Времена года", countOfWords: 16, array: seasonsData, watchImage: "WatchSeasons"),]
    }
    
    static func getMainTopics () -> [TestTopic] {
        return [TestTopic(image: "Professions", header: "Профессии", countOfWords: 51, array: professionsData, watchImage: "WatchProfessions"),
                TestTopic(image: "Animals", header: "Животные", countOfWords: 42, array: animalsData, watchImage: "WatchAnimals"),
                TestTopic(image: "Vegetables", header: "Овощи", countOfWords: 21, array: vegetablesData, watchImage: "WatchVegetables"),
                TestTopic(image: "Weather", header: "Погода", countOfWords: 43, array: weatherData, watchImage: "WatchWeather"),
                TestTopic(image: "Sweater", header: "Одежда", countOfWords: 55, array: clothesData, watchImage: "WatchSweater"),
                TestTopic(image: "Sport", header: "Спорт", countOfWords: 47 , array: sportData, watchImage: "WatchSport"),
                TestTopic(image: "Food", header: "Еда", countOfWords: 48,array: foodData, watchImage: "WatchFood"),
                TestTopic(image: "Furniture", header: "Мебель", countOfWords: 42, array: furnitureData, watchImage: "WatchFurniture"),
                TestTopic(image: "Countries", header: "Страны", countOfWords: 34, array: counriesData, watchImage: "WatchCountries"),
                TestTopic(image: "Feelings", header: "Чувства", countOfWords: 34, array: feelData, watchImage: "WatchFeelings"),
                TestTopic(image: "Appearance", header: "Внешность", countOfWords: 60, array: appearanceData, watchImage: "WatchAppearance")]
    }
    static func getBannersTopics () -> [TestTopic] {
        return [TestTopic(image: "Space", header: "Космос", countOfWords: 49, array: spaceData, watchImage: "WatchSpace"),
                TestTopic(image: "Cooking", header: "Готовка", countOfWords: 50, array: cookingData, watchImage: "WatchCooking")]
    }
    
    static func getAnyWaysTopics () -> [TestTopic] {
        return [TestTopic(image: "Doctor", header: "В больнице", countOfWords: 48, array: hospitalData, watchImage: "WatchDoctor"),
                TestTopic(image: "Judgement", header: "В суде", countOfWords: 70, array: judgeData, watchImage: "WatchJudge"),
                TestTopic(image: "School", header: "В школе", countOfWords: 43, array: schoolData, watchImage: "WatchSchool"),
                TestTopic(image: "InterView", header: "На собеседовании", countOfWords: 67, array: interviewData, watchImage: "WatchInterview"),
                TestTopic(image: "Pilot", header: "В самолете", countOfWords: 47, array: airPlaneData, watchImage: "WatchPilot"),
                TestTopic(image: "City", header: "В городе", countOfWords: 55, array: cityData, watchImage: "WatchCity"),
                TestTopic(image: "Hotel", header: "В отеле", countOfWords: 51, array: hotelData, watchImage: "WatchHotel"),
                TestTopic(image: "Detective", header: "У детектива", countOfWords: 75, array: detectiveData, watchImage: "WatchDetective"),
                TestTopic(image: "Nature", header: "На природе", countOfWords: 40, array: natureData, watchImage: "WatchNature"),
                TestTopic(image: "Travelling", header: "В путешествии", countOfWords: 64, array: travellingData, watchImage: "WatchTravelling"),
                TestTopic(image: "Shop", header: "В магазине", countOfWords: 53, array: shopData, watchImage: "WatchShop"),
                TestTopic(image: "Wedding", header: "На свадьбе", countOfWords: 61, array: weddingData, watchImage: "WatchWedding"),]
    }
    // Start Update
    
    static func getTravellingTopics () -> [TestTopic] {
        return [TestTopic(image: "Travelling", header: "Основное", countOfWords: 64, array: travellingData, watchImage: "WatchTravelling"),
                TestTopic(image: "Hotel", header: "В отеле", countOfWords: 51, array: hotelData, watchImage: "WatchHotel"),
                TestTopic(image: "Restaurant", header: "В ресторане", countOfWords: 56, array: restaurantData, watchImage: "WatchRestaurant"),
                TestTopic(image: "Shop", header: "В магазине", countOfWords: 53, array: shopData, watchImage: "WatchShop"),
                TestTopic(image: "Beach", header: "На пляже", countOfWords: 66, array: SeaAndBeachData, watchImage: "WatchBeach"),
                TestTopic(image: "Village", header: "В деревне", countOfWords: 44, array: villageData, watchImage: "WatchVillage")
        ]
    }
    
    static func getBannersTopics2 () -> [TestTopic] {
        return [TestTopic(image: "Wedding", header: "На свадьбе", countOfWords: 61, array: weddingData, watchImage: "WatchWedding"),
                TestTopic(image: "City", header: "В городе", countOfWords: 55, array: cityData, watchImage: "WatchCity")]
    }
    
    static func getTopicsForProfessions () -> [TestTopic] {
        return [TestTopic(image: "InterView", header: "Интервью", countOfWords: 67, array: interviewData, watchImage: "WatchInterview"),
                TestTopic(image: "Doctor", header: "Врач", countOfWords: 48, array: hospitalData, watchImage: "WatchDoctor"),
                TestTopic(image: "Judgement", header: "Судья", countOfWords: 70, array: judgeData, watchImage: "WatchJudge"),
                TestTopic(image: "School", header: "Ученик", countOfWords: 43, array: schoolData, watchImage: "WatchSchool"),
                TestTopic(image: "Pilot", header: "Пилот", countOfWords: 47, array: airPlaneData, watchImage: "WatchPilot"),
                TestTopic(image: "Detective", header: "Детектив", countOfWords: 75, array: detectiveData, watchImage: "WatchDetective")]
    }
    
    // Final Update
    
    static func getTopicsForBookScroll () -> [TestTopic] {
        return [TestTopic(image: "bigCheese", header: "Еда", countOfWords: 48, array: foodData, watchImage: "WatchFood"),
                TestTopic(image: "bigTravelling", header: "В путешествии", countOfWords: 64, array: travellingData, watchImage: "WatchTravelling"),
                TestTopic(image: "bigDoctor", header: "В больнице", countOfWords: 48, array: hospitalData, watchImage: "WatchDoctor"),
                TestTopic(image: "bigSweater", header: "Одежда", countOfWords: 55, array: clothesData, watchImage: "WatchSweater")]
    }
    static func getTopicsForParts () -> [TestTopic] {
        return [TestTopic(image: "diamond1", header: "Топ глаголов", countOfWords: 100, array: verbsData, watchImage: "WatchDiamond1"),
                TestTopic(image: "diamond2", header: "Топ существительных", countOfWords: 100, array: nounsData, watchImage: "WatchDiamond2"),
                TestTopic(image: "diamond3", header: "Топ прилагательных", countOfWords: 100, array: adjData, watchImage: "WatchDiamond3"),
                TestTopic(image: "diamond4", header: "Топ наречий", countOfWords: 100, array: advData, watchImage: "WatchDiamond4"),
                TestTopic(image: "diamond5", header: "Топ союзы", countOfWords: 35, array: unionData, watchImage: "WatchDiamond5"),
                TestTopic(image: "diamond6", header: "Топ предлогов", countOfWords: 21, array: prepData, watchImage: "WatchDiamond6")]
    }
    static func getTopicsForinfinity () -> [TestTopic] {
        return [TestTopic(image: "Verbs", header: "Глаголы", countOfWords: 200, array: infVerbsData, watchImage: "WatchVerbs"),
                TestTopic(image: "Nouns", header: "Существительные", countOfWords: 200, array: infNounsData, watchImage: "WatchNouns"),
                TestTopic(image: "adj", header: "Прилагательные", countOfWords: 200, array: infAdjData, watchImage: "WatchAdj")]
    }
    
    static func getPhrasalVerbs () -> [TestTopic] {
        return [TestTopic(image: "book1", header: "GO", countOfWords: 16, array: goData, watchImage: "WatchBook1"),
                TestTopic(image: "book2", header: "GET", countOfWords: 21, array: getData, watchImage: "WatchBook2"),
                TestTopic(image: "book3", header: "GIVE", countOfWords: 8, array: giveData, watchImage: "WatchBook3"),
                TestTopic(image: "book4", header: "LOOK", countOfWords: 17, array: lookData, watchImage: "WatchBook4"),
                TestTopic(image: "book5", header: "MAKE", countOfWords: 8, array: makeData, watchImage: "WatchBook5"),
                TestTopic(image: "book1", header: "TAKE", countOfWords: 15 , array: takeData, watchImage: "WatchBook1"),
                TestTopic(image: "book4", header: "BRING", countOfWords: 14,array: bringData, watchImage: "WatchBook4"),
                TestTopic(image: "book1", header: "Другие", countOfWords: 63, array: phrasalData, watchImage: "WatchBook1")]
    }
    
    static func getAddTopics () -> [TestTopic] {
        return [TestTopic(image: "Space", header: "Наука", countOfWords: 29, array: eng5Data, watchImage: "WatchSpace", author: "5 английских слов"),
                TestTopic(image: "Cooking", header: "Кино", countOfWords: 22, array: engLineData, watchImage: "WatchCooking", author: "EngLine")]
    }
    
}



class Word {
    let word : String
    let translate : String
    var tranRU1: String = ""
    var tranRU2: String = ""
    var tranRU3: String = ""
    var tranEN1: String = ""
    var tranEN2: String = ""
    var tranEN3: String = ""
    let example1: String
    let example2: String
    let partOfSpeeach : String
    
    
    init(word: String, translate : String, tranRU1: String,tranRU2: String,tranRU3: String, tranEN1: String,tranEN2: String,tranEN3: String, example: String, pof : String) {
        self.word = word
        self.translate = translate
        self.tranRU1 = tranRU1
        self.tranRU2 = tranRU2
        self.tranRU3 = tranRU3
        self.tranEN1 = tranEN1
        self.tranEN2 = tranEN2
        self.tranEN3 = tranEN3
        self.example1 = example
        self.example2 = example
        self.partOfSpeeach = pof
    }
    
    init(dic : NSDictionary) {
        self.word = dic.object(forKey: "word") as! String
        self.translate = dic.object(forKey: "translate") as! String
        self.tranRU1 = dic.object(forKey: "tranInRU1") as! String
        self.tranRU2 = dic.object(forKey: "tranInRU2") as! String
        self.tranRU3 = dic.object(forKey: "tranInRU3") as! String
        self.tranEN1 = dic.object(forKey: "tranInENG1") as! String
        self.tranEN2 = dic.object(forKey: "tranInENG2") as! String
        self.tranEN3 = dic.object(forKey: "tranInENG3") as! String
        self.example1 = dic.object(forKey: "example1") as! String
        self.example2 = dic.object(forKey: "example2") as! String
        self.partOfSpeeach = dic.object(forKey: "pOfSpeeach") as! String
        
    }
    init(dic : NSDictionary, arrayRU: [String], arrayEN : [String]) {
        self.word = dic.object(forKey: "word") as! String
        self.translate = dic.object(forKey: "translate") as! String
        self.tranRU1 = arrayRU[0]
        self.tranRU2 = arrayRU[1]
        self.tranRU3 = arrayRU[2]
        self.tranEN1 = arrayEN[0]
        self.tranEN2 = arrayEN[1]
        self.tranEN3 = arrayEN[2]
        
        if tranEN1 == word {
            tranEN1 = arrayEN[3]
        }
        
        if tranEN2 == word {
            tranEN2 = arrayEN[3]
        }
        
        if tranEN3 == word {
            tranEN3 = arrayEN[3]
        }
        
        if tranRU1 == translate {
            tranRU1 = arrayRU[3]
        }
        
        if tranRU2 == translate {
            tranRU2 = arrayRU[3]
        }
        
        if tranRU3 == translate {
            tranRU3 = arrayRU[3]
        }
        
        self.example1 = dic.object(forKey: "example1") as! String
        self.example2 = dic.object(forKey: "example2") as! String
        self.partOfSpeeach = dic.object(forKey: "pOfSpeeach") as! String
        
    }
}



private func loadNumbersTopic() {
    var returnArray : [Word] = []
    let array = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "NumbersData", ofType: "plist")!)!
    loadWrongWords(array: array, arrayRU: &ruVariantsForNumbers, arrayEN: &enVariantsForNumbers)
    let ru = ruVariantsForNumbers.shuffled()
    let en = enVariantsForNumbers.shuffled()
    var currentIndex = 0
    for i in array {
        if currentIndex + 3 >= 20 {
            currentIndex = 0
        }
        let tmp = Word(dic : i as! NSDictionary, arrayRU: [ru[currentIndex], ru[currentIndex + 1], ru[currentIndex + 2],ru[currentIndex + 3]], arrayEN: [en[currentIndex], en[currentIndex + 1], en[currentIndex + 2], en[currentIndex + 3]])
        currentIndex += 1
        returnArray.append(tmp)
    }
    // ПЕРЕВОРОТ ДЛЯ УДОБСТВА
    for i in 0...9 {
        let t = returnArray[i]
        returnArray[i] = returnArray[19 - i]
        returnArray[19 - i] = t
    }
    numbersWordsData = returnArray
}

private func setupTest(name: String, filledArray: inout [Word], count: Int) {
    var returnArray : [Word] = []
    let array = NSArray.init(contentsOfFile: Bundle.main.path(forResource: name, ofType: "plist")!)!
    var arrayRU = [String]()
    var arrayEN = [String]()
    loadWrongWords(array: array, arrayRU: &arrayRU, arrayEN: &arrayEN)
    let ru = arrayRU.shuffled()
    let en = arrayEN.shuffled()
    var currentIndex = 0
    for i in array {
        if currentIndex + 3 >= count {
            currentIndex = 0
        }
        let tmp = Word(dic : i as! NSDictionary, arrayRU: [ru[currentIndex], ru[currentIndex + 1], ru[currentIndex + 2],ru[currentIndex + 3]], arrayEN: [en[currentIndex], en[currentIndex + 1], en[currentIndex + 2], en[currentIndex + 3]])
        currentIndex += 1
        returnArray.append(tmp)
    }
    filledArray = returnArray
}

private func loadWrongWords (array: NSArray, arrayRU: inout [String], arrayEN: inout [String]) {
    for i in array {
        let dic = i as! NSDictionary
        arrayEN.append(dic.object(forKey: "word") as! String)
        arrayRU.append(dic.object(forKey: "translate") as! String)
    }
}

private func loadFruitTopic() {
    var returnArray : [Word] = []
    let array = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "FruitData", ofType: "plist")!)!
    for i in array {
        let tmp = Word(dic: i as! NSDictionary)
        returnArray.append(tmp)
    }
    fruitWordsData = returnArray
}

var enTest = [String]()
var ruTest = [String]()
var testDataArray = [Word]()

func testData () {
    setupTest(name: "InfNounsData", filledArray: &testDataArray, count: 100)
    var array = [String]()
    for i in 0...99 {
        array.append(nounsData[i].word)
    }
    for i in 0...99 {
        if array.contains(testDataArray[i].word) {
            print(i)
        }
    }
}

func setupInfData(infName : String, secondArray : [Word], filledArray : inout [Word]) {
    var infArray = [Word]()
    setupTest(name: infName, filledArray: &infArray, count: 100)
    var currentInsex1 = 0
    var currentIndex2 = 0
    for i in 0...199 {
        if i % 2 == 0 {
            filledArray.append(infArray[currentInsex1])
            currentInsex1 += 1
        }
        if i % 2 == 1 {
            filledArray.append(secondArray[99 - currentIndex2])
            currentIndex2 += 1
        }
    }
}

func getCorrectWords(number: Int) -> String {
    var result = ""
    
    switch number {
    case 10...20:
        result = " слов"
    default:
        switch number % 10 {
        case 0:
            result = " слов"
        case 1:
            result = " слово"
        case 2...4:
            result = " слова"
        case 5...9:
            result = " слов"
        default: break
        }
    }
    return result
}

func turnArray() {
    
    for i in 0...49 {
        let t = goldData[i]
        goldData[i] = goldData[99 - i]
        goldData[99 - i] = t
    }
}

func loadAllData() {
    
    setupTest(name: "SilverData", filledArray: &silverData, count: 100)
    setupTest(name: "GoldData", filledArray: &goldData, count: 100)
    turnArray() // переворот для удобства
    
    // PHRASAL TOPICS
    setupTest(name: "GODATA", filledArray: &goData, count: 16)
    setupTest(name: "GETDATA", filledArray: &getData, count: 21)
    setupTest(name: "GIVEDATA", filledArray: &giveData, count: 8)
    setupTest(name: "LOOKDATA", filledArray: &lookData, count: 17)
    setupTest(name: "MAKEDATA", filledArray: &makeData, count: 8)
    setupTest(name: "TAKEDATA", filledArray: &takeData, count: 15)
    setupTest(name: "BRINGDATA", filledArray: &bringData, count: 14)
    setupTest(name: "PhrasalVerbsData", filledArray: &phrasalData, count: 63)
    
    //
    setupTest(name: "PrepData", filledArray: &prepData, count: 21)
    setupTest(name: "UnionsData", filledArray: &unionData, count: 35)
    setupTest(name: "TopNounsData", filledArray: &nounsData, count: 100)
    setupTest(name: "TopAdjData", filledArray: &adjData, count: 100)
    setupTest(name: "TopAdverbsData", filledArray: &advData, count: 100)
    setupTest(name: "TopVerbsData", filledArray: &verbsData, count: 100)
    
    // inf Topics
    
    setupInfData(infName: "InfVerbsData", secondArray: verbsData, filledArray: &infVerbsData)
    setupInfData(infName: "InfNounsData", secondArray: nounsData, filledArray: &infNounsData)
    setupInfData(infName: "InfAdjectiveData", secondArray: adjData, filledArray: &infAdjData)
    
    // Banners TOPICS
    setupTest(name: "SpaceData", filledArray: &spaceData, count: 49)
    setupTest(name: "CookingData",  filledArray: &cookingData, count: 50)
    setupTest(name: "FiveEnglishWords", filledArray: &eng5Data, count: 29)
    setupTest(name: "EngLine", filledArray: &engLineData, count: 22)
    
    
    //ANY WAYS SETUP
    setupTest(name: "NatureData", filledArray: &natureData, count: 40)
    setupTest(name: "HospitalData", filledArray: &hospitalData, count: 48)
    setupTest(name: "AirPlaneData",  filledArray: &airPlaneData, count: 47)
    setupTest(name: "CityData", filledArray: &cityData, count: 55)
    setupTest(name: "Hotel",  filledArray: &hotelData, count: 51)
    setupTest(name: "Detective",  filledArray: &detectiveData, count: 75)
    setupTest(name: "ShopData", filledArray: &shopData, count: 53)
    setupTest(name: "SchoolData", filledArray: &schoolData, count: 43)
    setupTest(name: "TravellingData", filledArray: &travellingData, count: 64)
    setupTest(name: "JudgeData", filledArray: &judgeData, count: 70)
    setupTest(name: "Wedding", filledArray: &weddingData, count: 61)
    setupTest(name: "InterviewData", filledArray: &interviewData, count: 67)
    setupTest(name: "RestaurantData", filledArray: &restaurantData, count: 56)
    setupTest(name: "SeaAndBeach", filledArray: &SeaAndBeachData, count: 66)
    setupTest(name: "VillageData", filledArray: &villageData, count: 44)
    //
    setupTest(name: "Countries", filledArray: &counriesData, count: 34)
    setupTest(name: "SportData", filledArray: &sportData, count: 47)
    setupTest(name: "FoodData", filledArray: &foodData, count: 48)
    setupTest(name: "Furniture", filledArray: &furnitureData, count: 42)
    setupTest(name: "AppearanceData", filledArray: &appearanceData, count: 60)
    setupTest(name: "Clothes", filledArray: &clothesData, count: 55)
    setupTest(name: "WeatherData", filledArray: &weatherData, count: 43)
    setupTest(name: "FeelingsData", filledArray: &feelData, count: 34)
    setupTest(name: "VegetablesData", filledArray: &vegetablesData, count: 21)
    setupTest(name: "AnimalsData", filledArray: &animalsData, count: 42)
    setupTest(name: "ProfessionsData", filledArray: &professionsData, count: 51)
    setupTest(name: "NumbersData", filledArray: &numbersWordsData, count: 20)
    setupTest(name: "SeasonsData", filledArray: &seasonsData, count: 16)
    setupTest(name: "ColorsData", filledArray: &colorsData, count: 40)
    setupTest(name: "PetsData", filledArray: &petsData, count: 21)
    setupTest(name: "Transport", filledArray: &transportData, count: 19)
    setupTest(name: "PartsOfFamily", filledArray: &partsOfFamilyData, count: 21)
    loadFruitTopic()
}
