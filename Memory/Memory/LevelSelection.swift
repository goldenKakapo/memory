//
//  LevelSelection.swift
//  Memory
//
//  Created by Ismael on 28/5/18.
//  Copyright © 2018 David Isma. All rights reserved.
//

import UIKit

class LevelSelection: UIViewController {
    let defaults = UserDefaults.standard

    @IBAction func hardBut(_ sender: Any) {
        self.defaults.set(2,forKey: "difficulty")
        print("hard mode")
    }
    @IBAction func midBut(_ sender: UIButton) {
        self.defaults.set(1,forKey: "difficulty")
        print("medium mode")
    }
    @IBAction func easyBut(_ sender: UIButton) {
        self.defaults.set(0,forKey: "difficulty")
        print("easy mode")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
