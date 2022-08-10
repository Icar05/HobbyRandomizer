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
    
    private var autoRelaunch = false

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
        }
        
        let modelToRestore = timerUtil.getState()
        self.timerView.setDisplayColorPrefs(color: appPreferences.timerColor, singleColor: appPreferences.timerSingleColor)
        self.timerView.restoreState(model: modelToRestore)
        self.autoRelaunch = appPreferences.autoRelaunch
        
    }

}

extension TimerViewController: TimerViewDelegate{
    
    
    public func didStartTimerClick() {
        self.timerUtil.startTimer()
    }
    
    public func didStopTimerClick() {
        self.timerUtil.stopTimer()
    }
    
    public func didRefreshClick() {
        self.timerUtil.stopSound()
        self.autoRelaunch ? timerUtil.startTimer() : timerUtil.refreshTimer()
    }
    
}


extension TimerViewController: TimerUtilDelegate{
    
    
    public func onTimerStart() {
        self.timerView.onTimerStart()
    }

    public func onTimerStop(maxValue: Int) {
        self.timerView.onTimerStop(maxValue: maxValue)
    }
    
    public func onTimerFinished(maxValue: Int) {
        self.timerView.onTimerFinished(maxValue: maxValue)
    }
    
    public func onTimerUpdate(current: Int, max: Int) {
        self.timerView.onTimerUpdate(current: current, max: max)
    }
    
    public func needDebug(value: String) {
        self.timerView.updateElapsedLabel(value: value)
    }
    
}
