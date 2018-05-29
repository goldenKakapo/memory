//
//  MainController.swift
//  Memory
//
//  Created by Enti Mobile on 29/5/18.
//  Copyright © 2018 David Isma. All rights reserved.
//

import UIKit
import AVFoundation
class MainController: UIViewController {
var music: AVAudioPlayer?
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "Music", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            if (music==nil){
                music = try AVAudioPlayer(contentsOf: url)
                music?.play()
                
                print("rises")
            }
            
        } catch {
            // couldn't load file :(
        }
        // Do any additional setup after loading the view.
        
        var userName = defaults.string(forKey: "userName")
        print(userName)
        if(userName==nil)
        {
            //Popup for userName
            let alert = UIAlertController(title: "Welcome", message: "Enter User Name", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = "Player 1"
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
                self.defaults.set(textField.text,forKey: "userName")
                userName = self.defaults.string(forKey: "userName")
                self.defaults.set(0, forKey: "numScores")
                //print(userName)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func MusicTouch(_ sender: UIButton) {
        if(!(music==nil)){
            if(music?.isPlaying)!{
                music?.stop()
            }else{
                music?.play()
            }
        
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
