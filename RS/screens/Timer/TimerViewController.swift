//
//  TimerViewController.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

public final class TimerViewController: UIViewController {
    
    

    @IBOutlet weak var timerView: TimerView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.timerView.delegate = self
    }

}

extension TimerViewController: TimerViewDelegate{
    
    public func onTimeGone() {
        print("onTimerFinished")
    }
    
    
}
