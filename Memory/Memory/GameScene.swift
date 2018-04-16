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
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var id_cards = [Int]()
    var card1 = SKSpriteNode()
    var card2 = SKSpriteNode()
    var card3 = SKSpriteNode()
    var card4 = SKSpriteNode()
    var card5 = SKSpriteNode()
    var card6 = SKSpriteNode()
    
    var card12 = SKSpriteNode()
    var card22 = SKSpriteNode()
    var card32 = SKSpriteNode()
    var card42 = SKSpriteNode()
    var card52 = SKSpriteNode()
    var card62 = SKSpriteNode()
    
    var count1 = 0
    var count2 = 0
    var count3 = 0
    var count4 = 0
    var count5 = 0
    var count6 = 0
    
    var pointer = CGPoint()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        card1 = SKSpriteNode(imageNamed: "1")
        card1.setScale(1)
        //card1.position = CGPoint(x: 0.5, y: 0.5)

        
        card2 = SKSpriteNode(imageNamed: "2")
        card2.setScale(1)

        
        card3 = SKSpriteNode(imageNamed: "3")
        card3.setScale(1)
        //card1.position = CGPoint(x: 0.5, y: 0.5)

        
        card4 = SKSpriteNode(imageNamed: "4")
        card4.setScale(1)
        //card1.position = CGPoint(x: 0.5, y: 0.5)

        
        card5 = SKSpriteNode(imageNamed: "5")
        card5.setScale(1)
        //card1.position = CGPoint(x: 0.5, y: 0.5)

        
        card6 = SKSpriteNode(imageNamed: "6")
        card6.setScale(1)
        //card1.position = CGPoint(x: 0.5, y: 0.5)

        
        card12 = SKSpriteNode(imageNamed: "1")
        card12.setScale(1)
        //card1.position = CGPoint(x: 0.5, y: 0.5)

        
        card22 = SKSpriteNode(imageNamed: "2")
        card22.setScale(1)

        
        card32 = SKSpriteNode(imageNamed: "3")
        card32.setScale(1)
        //card1.position = CGPoint(x: 0.5, y: 0.5)

        
        card42 = SKSpriteNode(imageNamed: "4")
        card42.setScale(1)
        //card1.position = CGPoint(x: 0.5, y: 0.5)

        
        card52 = SKSpriteNode(imageNamed: "5")
        card52.setScale(1)
        //card1.position = CGPoint(x: 0.5, y: 0.5)

        
        card62 = SKSpriteNode(imageNamed: "6")
        card62.setScale(1)
        //card1.position = CGPoint(x: 0.5, y: 0.5)

        pointer = CGPoint(x: 0.5, y: 0.5)
        print("pointer x: ",pointer.x)
        card1.position = CGPoint(x: pointer.x,y: pointer.y)
        
    }
    
    override func sceneDidLoad() {

        
        self.lastUpdateTime = 0
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        
        //ID cartes
        //Easy (12 cartes) -> 6 ID (0...5)
        for index in 0...11 {
            var has_id:Bool = false
            var id:UInt32 = 0
            while(has_id==false){
                id = arc4random_uniform(6)
                var count:Int = 0
                if(index>0){
                    for index2 in 0...index-1 {
                        if(id_cards[index2]==id) {count=count+1}
                    }
                }
                if(count<2){ has_id=true}
            }
            id_cards.append(Int(id))
            print("id: ",id)
            /*if id==1 {
                count1 = count1+1
                if count1 == 1{
                    card1.position = CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>)
                }
                else{
                    card12.position = CGPoint(x: <#T##CGFloat#>, y: <#T##CGFloat#>)
                }
            }
            else if id==2 {count2 = count2+1}
            else if id==3 {count3 = count2+1}
            else if id==4 {count4 = count2+1}
            else if id==5 {count5 = count2+1}
            else if id==6 {count6 = count2+1}*/
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
            debugPrint(pos)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
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
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
