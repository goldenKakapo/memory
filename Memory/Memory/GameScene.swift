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
   
    private var lastUpdateTime : TimeInterval = 0
    override func didMove(to view: SKView) {
     
        
    }
    
    //TODO Condició de victoria
    
    
    func loadCards(){
        if (!CardsLoaded){
            self.isUserInteractionEnabled = true;
            //Todo, ajustar el init POINT (Marge superior esquerre) i els intervals de files i columnes estiguin en relació al tamany de la pantalla
            let initPoint = vector2(-130.0, 200.0)
            
            let intervaloFilas = 110.0
            let intervaloColumnas = 110.0;
            
            let nCols = 3.0
            var BackgroundSpriteName="6" //TODO (modificar 6 per sprite carta per darrere)
            
            var curRow = 0.0;
            var curCol = -1.0;
            
            for index in 0...11 {
                
                var idCard = index%6
                var c=Card(imageNamed: BackgroundSpriteName)
                
               
                c.setScale(1)
                c.value=idCard;
                c.name="Card"
                
                
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
                    curCol=0.0;
                    curRow=curRow+1.0
                }
                
                card.position = CGPoint(x: initPoint.x + (curCol * intervaloColumnas), y: initPoint.y - (curRow * intervaloFilas))
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
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
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
