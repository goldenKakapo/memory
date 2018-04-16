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
    
    
  
    func show(){
        self.texture=SKTexture(imageNamed: String(value+1))
        revealed=true;
    }
    
    func hide(){
        self.texture=SKTexture(imageNamed: "6") //todo Modificar 6 per sprite carta darrere
        revealed=false;
    }
     
    
   
}

