//
//  GameScene.swift
//  Memory
//
//  Created by Enti Mobile on 06/03/2018.
//  Copyright © 2018 David Isma. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    
    var score=0;
    var multiplier = 1;
    
    var time=60;
    var timeStarted : TimeInterval = 0
    
    var timeSinceLevelStart=0.0;
    
    var textTemps = SKLabelNode(fontNamed: "Chalkduster")
    var textScore = SKLabelNode(fontNamed: "Chalkduster")
    var textMultipier = SKLabelNode(fontNamed: "Chalkduster")
    
    var tempsRestant = 0;
    
    
    var cards:[Card] = []
    var CardsLoaded=false;
    
    var canGetTouch=true;
    
    var touchedCard:Card?
    
    var count_matches = 0
    var matches = 6
    
    
    //variables billy
    var playing=true;
    var difficulty = 0
    
    var music: AVAudioPlayer?
    var FX: AVAudioPlayer?
    
  
    
    
    
    
    private var lastUpdateTime : TimeInterval = 0
    override func didMove(to view: SKView) {
        
        
    }
    
    func addWinText(){
        playing=false;
        
        setScore(increment: tempsRestant * 10)
        let youWin = SKSpriteNode(imageNamed: "youWin.png")
        youWin.size = CGSize(width: youWin.size.width/2, height: youWin.size.height/2)
        youWin.position = CGPoint(x: 0, y: 0)
        self.addChild(youWin)
    }
    
    //TODO Condició de victoria
    func isGameFinished()  {
        count_matches = count_matches+1
        if(count_matches==matches) {
            count_matches=0
            CardsLoaded = false
            addWinText()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.removeAllChildren()
                self.cards.removeAll()
                self.loadCards()
            }
        }
    }
    
    func setScore(increment:Int){
        self.score += increment;
        self.textScore.text = String(self.score)
    }
    
    func playCardFlipFX(){
        let path = Bundle.main.path(forResource: "flipcard", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
           
                FX = try AVAudioPlayer(contentsOf: url)
                FX?.play()
            
            
        } catch {
            // couldn't load file :(
        }
        
    }
    
    
    func loadCards(){
        if (!CardsLoaded){
            
            
            
            
            
            
            self.isUserInteractionEnabled = true;
            //Todo, ajustar el init POINT (Marge superior esquerre) i els intervals de files i columnes estiguin en relació al tamany de la pantalla
            var initPoint = vector2(-(Double(self.size.width) / 2.0) , (Double(self.size.height) / 2.0))
            
            let intervaloFilas = Double(self.size.height) / 4.0
            let intervaloColumnas = Double(self.size.width) / 3.0
            
            initPoint.x -= intervaloColumnas / 2.0
            initPoint.y += intervaloFilas / 2.0
            
            let nCols = 4.0
            var BackgroundSpriteName="BackCard" //TODO (modificar 6 per sprite carta per darrere)
            
            var curRow = 1.0;
            var curCol = -0.0;
            
            for index in 0...11 {
                
                var idCard = index%6
                var c=Card(imageNamed: BackgroundSpriteName)
                
                c.originalWidth = c.size.width
                c.setScale(0.6)
                c.value=idCard;
                c.spriteName = String(self.difficulty) + "-" + String((index%6)+1);
                c.name="Card"
                c.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                
                cards.append(c)
                self.addChild(c);
            }
            
            for i in 0..<(cards.count - 1) {
                let j = Int(arc4random_uniform(UInt32(cards.count - i))) + i
                
                var tempCard = cards[i]
                cards[i]=cards[j]
                cards[j]=tempCard
                
            }
            
            for card in cards{
                curCol=curCol+1.0
                
                if (curCol==nCols){
                    curCol=1.0;
                    curRow=curRow+1.0
                }
                var position = CGPoint(x: initPoint.x + (curCol * intervaloColumnas), y: initPoint.y - (curRow * intervaloFilas))
                card.moveCardTo(destination: position)
                // card.position = CGPoint(x: initPoint.x + (curCol * intervaloColumnas), y: initPoint.y - (curRow * intervaloFilas))
            }
            
            CardsLoaded=true;
        }
    }
    
    
    
    override func sceneDidLoad() {
        
        
        loadCards();
        
        let height = self.size.height / 2.0
        let width = self.size.width / 3.0
        
       
        
        
        
        
        self.textTemps = SKLabelNode(fontNamed: "Chalkduster")
        self.textTemps.text = "30"
        self.textTemps.fontSize = 65
        self.textTemps.fontColor = SKColor.green
        self.textTemps.position = CGPoint(x: frame.midX, y: height)
        
        addChild(self.textTemps)
        
        self.textScore = SKLabelNode(fontNamed: "Chalkduster")
        self.textScore.text = "0"
        self.textScore.fontSize = 40
        self.textScore.fontColor = SKColor.green
        self.textScore.position = CGPoint(x: width, y: height)
        
        addChild(self.textScore)
        
        self.textMultipier = SKLabelNode(fontNamed: "Chalkduster")
        self.textMultipier.text = "x1"
        self.textMultipier.fontSize = 40
        self.textMultipier.fontColor = SKColor.green
        self.textMultipier.position = CGPoint(x: -width, y: height)
        
        addChild(self.textMultipier)
        
        
        
        let path = Bundle.main.path(forResource: "Music", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            if (music==nil){
                music = try AVAudioPlayer(contentsOf: url)
            //    music?.play()
            }
            
        } catch {
            // couldn't load file :(
        }
        
       
        
    }
    
    func swapCards(c:Card, c2:Card){
        let p1 = c.position
        let p2 = c2.position
        
        c.moveCardTo(destination: p2)
        c2.moveCardTo(destination: p1)
    }
    
    
    
    func touched(card:Card){
        
        print(card.value)
        if (touchedCard != nil){
            canGetTouch=false;
            card.show();
            playCardFlipFX()
            if (card.value==touchedCard?.value){
                touchedCard=nil
                canGetTouch=true;
                isGameFinished()
                
                setScore(increment: 100 * self.multiplier)
                self.multiplier = self.multiplier+1
                self.textMultipier.text = "x" + String(self.multiplier)
                
            }else{
                
                
                
                self.multiplier=1
                self.textMultipier.text = "x" + String(self.multiplier)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                    
                    if(self.difficulty == 2){
                        self.swapCards(c:self.touchedCard!,c2:card)
                    }
                    // Your code with delay
                    self.canGetTouch=true;
                    card.hide()
                    self.playCardFlipFX()
                    self.touchedCard?.hide()
                    self.touchedCard=nil;
                    
                   
                }
            }
        }else{
            touchedCard=card
            card.show();
            playCardFlipFX()
            
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //TODO Crec que aqui hi ha bug, o aqui o a la funcio touched, pero el joc fa coses rares
        if (canGetTouch){
            let touch = touches.first
            let location = touch?.location(in: self)
            let node : SKNode = self.atPoint(location!)
            if node.name == "Card" {
                let card = node as! Card
                if (!card.revealed){
                    touched(card: card)
                }
            }
        }
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if (playing){
        
        if (self.timeStarted == 0){
            self.timeStarted = currentTime;
        }
        
        self.timeSinceLevelStart = currentTime - self.timeStarted
            
        self.tempsRestant=self.time - Int(self.timeSinceLevelStart)
        
        
        self.textTemps.text = String(self.tempsRestant)
            
            if (self.tempsRestant==0){
                self.playing=false
                
                //condicio derrota
            }
            
            
        
        
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        
        
        self.lastUpdateTime = currentTime
        }
    }
}
