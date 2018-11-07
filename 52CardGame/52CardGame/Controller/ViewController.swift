//
//  ViewController.swift
//  52CardGame
//
//  Created by Administrator on 31/10/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
   var cards = [Card]()
    var lives = 3 {
        didSet {
            self.liveLabel.text = "Lives: \(lives)"
        }
    }
    var score = 0 {
        didSet {
            self.scoreLabel.text = "Score: \(score)"
        }
    }
    
    var cardIndex  = 0
    var cardValue = ""
    
    
    @IBOutlet weak var liveLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    
    @IBOutlet weak var lowButton: UIButton!
    
    @IBOutlet weak var hiButton: UIButton!
    
    let endPoint = "http://cards.davidneal.io/api/cards"
    
    fileprivate func loadCardDeck() {
        
        lowButton.isEnabled = false
        hiButton.isEnabled = false
        
        let cardApi = CardAPIClient()
        cardApi.getCards(endPoint: endPoint) { (cardData) in
            
            DispatchQueue.main.async {
                self.cards = cardData ?? [Card]()
                print(self.cards.count as Any)
                //suflle cards
                self.cards = self.suffle()
                
                self.lowButton.isEnabled = true
                self.hiButton.isEnabled = true
                self.cardValue = self.cards[0].value ?? ""
                self.setDisplayCard()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lives = 3
        self.score = 0
        self.loadCardDeck()
        
    }
    
    
    
    @IBAction func lowButtonPress(_ sender: Any) {
        cardIndex += 1
        let nextCardValue = self.cards[cardIndex].value
        setDisplayCard()
        
        if   nextCardValue != self.cardValue {
            
            if !NextCardIsHigher(firstValue: self.cardValue, secondValue: nextCardValue!) {
                score += 1
                
            } else {
                lives -= 1
            }
        }
        self.cardValue = self.cards[cardIndex].value ?? ""
        
        checkGameOverReset()
    }
    
    fileprivate func resetLabels() {
        self.lives = 3
        self.score = 0
        self.cardIndex  = 0
        
        var suffle = self.suffle()
        self.cards = suffle
        suffle = [Card]()
    
        self.cardValue = self.cards[0].value ?? ""
        self.setDisplayCard()
    }
    
    fileprivate func checkGameOverReset() {
        if lives <= 0 {
            let alert = UIAlertController(title: "Game Over", message: "Your score is \(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                self.resetLabels()
                
            }))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func hiButtonPress(_ sender: Any) {
        cardIndex += 1
        let nextCardValue = self.cards[cardIndex].value ?? ""
        setDisplayCard()
        if   nextCardValue != self.cardValue {
            if NextCardIsHigher(firstValue: self.cardValue, secondValue: nextCardValue) {
                score += 1
                
            } else {
                lives -= 1
            }
        }
        self.cardValue = self.cards[cardIndex].value ?? ""
        
        checkGameOverReset()
    }
    
    func suitValue( suit: String)-> String {
        switch suit {
        case "spades" :
            return "S"
        case "diamonds":
            return "D"
        case "clubs":
            return "C"
        case "hearts":
            return "H"
        default:
            return ""
        }
    }
    
    func setDisplayCard() {
        let nextCardValue = self.cards[cardIndex].value ?? ""
        let nextCardSuit = self.cards[cardIndex].suit ?? ""
        let nextCardSuitShortdesc = self.suitValue(suit: nextCardSuit)
        let imageName = nextCardValue + nextCardSuitShortdesc //+  ".png"
      
        
      //  self.cardImageView.image = UIImage(named: imageName)
      // line above replaced to reduce image cache -free up memory
        if let imgPath = Bundle.main.path(forResource: imageName, ofType: "png") {
           self.cardImageView.image = UIImage(contentsOfFile: imgPath)
        }
    }
    
    
    func NextCardIsHigher(firstValue: String, secondValue: String)-> Bool {
        var defaultReturn = false
        var firstString = ""
        var secondString = ""
        
        switch firstValue {
        case "A" :
            firstString = "1"
        case "J" :
            firstString = "11"
        case "K" :
            firstString = "12"
        case "Q" :
            firstString = "13"
        default :
            firstString = firstValue
        }
        
        switch secondValue {
        case "A" :
            secondString = "1"
        case "J" :
            secondString = "11"
        case "K" :
            secondString = "12"
        case "Q" :
            secondString = "13"
        default :
            secondString = secondValue
        }
        
        ( Int(secondString)! >  Int(firstString)! ) ? (defaultReturn = true) : (defaultReturn = false)
        return defaultReturn
    }
    
    
    func suffle()-> [Card] {
        
        var shuffled = [Card]();
        for _ in 0..<self.cards.count {
            let rand = Int(arc4random_uniform(UInt32(self.cards.count)))
            shuffled.append(self.cards[rand])
            self.cards.remove(at: rand)
        }
        return shuffled
    }
}

