//
//  TimerViewController.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

public final class TimerViewController: UIViewController {
    
    
    
    private var soundUtil: SoundUtil? = nil

    @IBOutlet weak var timerView: TimerView!
    
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.timerView.delegate = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.soundUtil = getPlayer(sound: .Timer)
    }

}

extension TimerViewController: TimerViewDelegate{
    
    public func onTimeGone() {
        self.soundUtil?.play()
    }
    
}
