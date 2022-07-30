//
//  DebugViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import UIKit

public final class DebugViewController: UIViewController {
    
    
    private let presenter: DebugPresenter
    
    private var soundUtil: SoundUtil? = nil
    
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
    
    public override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)

           self.soundUtil = getAppComponent().getSoundUtil(sound: .Click)
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
        self.soundUtil?.play()
    }
    
    func onModelFound(randModel: RandomizerModel) {}
    
}
