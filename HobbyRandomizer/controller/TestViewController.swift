//
//  TestViewController.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import UIKit

class TestViewController: UIViewController {
    
    
    fileprivate var count = 7
    
    @IBOutlet weak var countLabel: BangButton!
    
    @IBOutlet weak var randomizer: RandomizerUtil!
    
    @IBOutlet weak var incrementLabel: BangButton!
    
    @IBOutlet weak var decrementLabel: BangButton!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.countLabel.text = "\(count)"
        
        
        incrementLabel.isUserInteractionEnabled = true
        decrementLabel.isUserInteractionEnabled = true
        
        let incGest = UITapGestureRecognizer(target: self, action: #selector(increment(tapGestureRecognizer:)))
        incrementLabel.addGestureRecognizer(incGest)
        
        let decGest = UITapGestureRecognizer(target: self, action: #selector(decrement(tapGestureRecognizer:)))
        decrementLabel.addGestureRecognizer(decGest)
    }


    @objc func increment(tapGestureRecognizer: UITapGestureRecognizer){
        if(count < 100){
            self.count += 1
            self.countLabel.text = "\(count)"
            self.randomizer.setDataSource(count: count)
        }
    }
   
    
    @objc func decrement(tapGestureRecognizer: UITapGestureRecognizer){
        if(count >  1){
            self.count -= 1
            self.countLabel.text = "\(count)"
            self.randomizer.setDataSource(count: count)
        }
    }
   
    
}

