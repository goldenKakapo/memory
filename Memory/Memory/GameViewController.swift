//
//  GameViewController.swift
//  Memory
//
//  Created by Enti Mobile on 06/03/2018.
//  Copyright © 2018 David Isma. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var id_cards = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
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
                }
            }
        }
    }


    @IBAction func button0(_ sender: Any) {
        print("but 0")
        print("id: ",id_cards[0])
    }
    
    @IBAction func button1(_ sender: Any) {
        print("but 1")
        print("id: ",id_cards[1])
    }
    
    @IBAction func button2(_ sender: Any) {
        print("but 2")
        print("id: ",id_cards[2])
    }
    
    @IBAction func button3(_ sender: Any) {
        print("but 3")
        print("id: ",id_cards[3])
    }
    
    @IBAction func button4(_ sender: Any) {
        print("but 4")
        print("id: ",id_cards[4])
    }
    
    @IBAction func button5(_ sender: Any) {
        print("but 5")
        print("id: ",id_cards[5])
    }
    
    @IBAction func button6(_ sender: Any) {
        print("but 6")
        print("id: ",id_cards[6])
    }
    
    @IBAction func button7(_ sender: Any) {
        print("but 7")
        print("id: ",id_cards[7])
    }
    
    @IBAction func button8(_ sender: Any) {
        print("but 8")
        print("id: ",id_cards[8])
    }
    
    @IBAction func button9(_ sender: Any) {
        print("but 9")
        print("id: ",id_cards[9])
    }
    
    @IBAction func button10(_ sender: Any) {
        print("but 10")
        print("id: ",id_cards[10])
    }
    
    @IBAction func button11(_ sender: Any) {
        print("but 11")
        print("id: ",id_cards[11])
    }
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}


