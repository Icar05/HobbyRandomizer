//
//  DebugViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import UIKit

public final class DebugViewController: UIViewController {
    
    
    private let presenter: DebugPresenter
    
    fileprivate var count = 7
    
    @IBOutlet weak var countLabel: BangButton!
    
    @IBOutlet weak var randomizer: RandomizerUtil!
    
    @IBOutlet weak var incrementLabel: BangButton!
    
    @IBOutlet weak var decrementLabel: BangButton!
    
    @IBOutlet weak var backgroundView: UIView!
    
    
    

    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: DebugPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "DebugViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        self.countLabel.text = "\(count)"
        
        
        self.incrementLabel.isUserInteractionEnabled = true
        self.decrementLabel.isUserInteractionEnabled = true
        
        let incGest = UITapGestureRecognizer(target: self, action: #selector(increment(tapGestureRecognizer:)))
        self.incrementLabel.addGestureRecognizer(incGest)
        
        let decGest = UITapGestureRecognizer(target: self, action: #selector(decrement(tapGestureRecognizer:)))
        self.decrementLabel.addGestureRecognizer(decGest)
        
        self.randomizer.delegate = self
        self.setGradientBackground()
    }
    
    private func setGradientBackground() {
        
        guard let top = UIColor.coolRed?.cgColor,
              let mid = UIColor.coolOrange?.cgColor,
              let bot = UIColor.coolGreen?.cgColor
        else {
            return
        }
        
        let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [top, mid, bot]
            gradientLayer.locations = [0.1, 0.5, 1.0]
            gradientLayer.frame = backgroundView.bounds
                
        backgroundView.layer.insertSublayer(gradientLayer, at:0)
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

extension DebugViewController: RandomizerUtilDelegate{
    func onDetectSector() {
        self.presenter.play()
    }
    
    func onModelFound(randModel: RandomizerModel) {}
    
}
