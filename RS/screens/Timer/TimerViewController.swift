//
//  TimerViewController.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

public final class TimerViewController: UIViewController {
    
    
    
    private let timerUtil: TimerUtil
    
    private let presenter: TimerPresenter

    @IBOutlet weak var timerView: TimerView!
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: TimerPresenter, timerUtil: TimerUtil) {
        self.presenter = presenter
        self.timerUtil = timerUtil
        super.init(nibName: "TimerViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.timerView.delegate = self
        self.timerUtil.delegate = self
    }
    
    func updateViewWithPreferences(appPreferences: AppPrefferencesModel){
        if(!self.timerUtil.isTimerStarted()){
            self.timerUtil.setMaxTime(maxTimeInMinutes: appPreferences.timerMinutes)
            self.timerView.setPreferences(preferences: appPreferences)
        }
    }

}

extension TimerViewController: TimerViewDelegate{
    
    public func actionButtonDidTap(needTimerStart: Bool) {
        needTimerStart ? timerUtil.startTimer() : timerUtil.stopTimer()
    }
    
}


extension TimerViewController: TimerUtilDelegate{
    
    public func onTimerStop() {
        self.timerView.onTimerStop()
    }
    
    public func onTimerUpdate(value: Int) {
        self.timerView.onTimerUpdate(value: value)
    }
    
    public func onTimerFinished() {
        self.timerView.onTimerFinished()
        
        print("ViewController: onTimerFinished")
    }
    
}
