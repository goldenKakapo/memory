//
//  Card.swift
//  Memory
//
//  Created by David on 16/04/2018.
//  Copyright © 2018 David Isma. All rights reserved.
//
import SpriteKit
import Foundation

class Card : SKSpriteNode
{
    
    var value = 0
    var revealed=false;
    var originalWidth = CGFloat(0)
    
  
    func show(){
        
        var shrink = SKAction.resize(toWidth: 0, duration: 0.25)
        self.run(shrink) {
            self.texture=SKTexture(imageNamed: String(self.value+1))
            var grow = SKAction.resize(toWidth: self.originalWidth, duration: 0.25)
            self.run(grow)
        }
        
       
        revealed=true;
    }
    
    func moveCardTo(destination : CGPoint){
        var xDist = (self.position.x - destination.x)
        var yDist = (self.position.y - destination.y)
        var distance = sqrt((xDist * xDist) + (yDist * yDist))
        var speed = 800.0;
        let time = Double(distance) / speed;
        
        
        var move = SKAction.move(to: destination, duration: time)
        
        self.run(move)
    }
    
    func hide(){
     
        
        
        var shrink = SKAction.resize(toWidth: 0, duration: 0.25)
        self.run(shrink) {
            self.texture=SKTexture(imageNamed: "BackCard")
            var grow = SKAction.resize(toWidth: self.originalWidth, duration: 0.25)
            self.run(grow)
        }
        
        
        revealed=false;
    }
     
    
   
}

