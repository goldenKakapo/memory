//
//  GameScene.swift
//  Memory
//
//  Created by Enti Mobile on 06/03/2018.
//  Copyright © 2018 David Isma. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    
    var cards:[Card] = []
    var CardsLoaded=false;
    
    var canGetTouch=true;
    
    var touchedCard:Card?
    
    var count_matches = 0
    var matches = 6
    
    private var lastUpdateTime : TimeInterval = 0
    override func didMove(to view: SKView) {
        
        
    }
    
    func addWinText(){
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
        
        
    }
    
    
    func touched(card:Card){
        
        print(card.value)
        if (touchedCard != nil){
            canGetTouch=false;
            card.show();
            if (card.value==touchedCard?.value){
                touchedCard=nil
                canGetTouch=true;
                isGameFinished()
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                    // Your code with delay
                    self.canGetTouch=true;
                    card.hide()
                    self.touchedCard?.hide()
                    self.touchedCard=nil;
                }
            }
        }else{
            touchedCard=card
            card.show();
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
