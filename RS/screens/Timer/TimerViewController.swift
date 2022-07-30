//
//  TimerViewController.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

public final class TimerViewController: UIViewController {
    
    
    
    private unowned var timerUtil: TimerUtil
    
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
            self.timerUtil.setTimerOnlyForeground(timerOnlyForeground: appPreferences.timerOnlyForeground)
            self.timerUtil.setSingleUpdateColor(value: appPreferences.timerSingleColor)
        }
        
        self.timerView.restoreState(state: timerUtil.getState())
        
    }

}

extension TimerViewController: TimerViewDelegate{
    
    
    public func didStartTimerClick() {
        timerUtil.startTimer()
    }
    
    public func didStopTimerClick() {
        timerUtil.stopTimer()
    }
    
    public func didRefreshClick() {
        timerUtil.refreshTimer()
    }
    
}


extension TimerViewController: TimerUtilDelegate{
    
    
    public func onTimerStart() {
        self.timerView.onTimerStart()
    }

    public func onTimerStop(maxValue: Int) {
        self.timerView.onTimerStop(maxValue: maxValue)
    }
    
    public func onTimerFinished() {
        self.timerView.onTimerFinished()
    }
    
    public func onTimerUpdate(current: Int, max: Int) {
        self.timerView.onTimerUpdate(current: current, max: max)
    }
    
    public func needDebug(value: String) {
        self.timerView.updateElapsedLabel(value: value)
    }
    
}
