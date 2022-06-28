//
//  DebugViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import UIKit

class DebugViewController: UIViewController {
    
    
    
    
    fileprivate var count = 7
    
    @IBOutlet weak var countLabel: BangButton!
    
    @IBOutlet weak var randomizer: RandomizerUtil!
    
    @IBOutlet weak var incrementLabel: BangButton!
    
    @IBOutlet weak var decrementLabel: BangButton!
    
    
    

    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: "DebugViewController", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.countLabel.text = "\(count)"
        
        
        self.incrementLabel.isUserInteractionEnabled = true
        self.decrementLabel.isUserInteractionEnabled = true
        
        let incGest = UITapGestureRecognizer(target: self, action: #selector(increment(tapGestureRecognizer:)))
        self.incrementLabel.addGestureRecognizer(incGest)
        
        let decGest = UITapGestureRecognizer(target: self, action: #selector(decrement(tapGestureRecognizer:)))
        self.decrementLabel.addGestureRecognizer(decGest)
        
        self.randomizer.contentView.gradient()
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
