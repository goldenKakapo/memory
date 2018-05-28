//
//  Ranking.swift
//  Memory
//
//  Created by Ismael on 28/5/18.
//  Copyright © 2018 David Isma. All rights reserved.
//

import UIKit

class Ranking: UIViewController {
    @IBOutlet var rankingLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    let defaults = UserDefaults.standard
    var numScores = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        rankingLabel.text = ""
        nameLabel.text = self.defaults.string(forKey: "userName")
        numScores = self.defaults.integer(forKey: "numScores")
        
        var allRanking: [Int] = []
        
        //Guardar totes puntuacions
        if(numScores>0){
            for i in 1...numScores {
                allRanking.append(self.defaults.integer(forKey: "score\(i)"))
            }
        //Ordenar
        allRanking.sort(by: >)
        print(allRanking)
        
            //Imprimir
            for i in allRanking {
            rankingLabel.text?.append("\(i)\n")
            }
        }


        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
