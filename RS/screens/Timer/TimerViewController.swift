//
//  TimerViewController.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

public final class TimerViewController: UIViewController {
    
    
    
    private let presenter: TimerPresenter
    
    private var soundUtil: SoundUtil? = nil

    @IBOutlet weak var timerView: TimerView!
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: TimerPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "TimerViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.timerView.delegate = self
        
        self.presenter.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.soundUtil = getPlayer(sound: .Timer)

        NotificationCenter.default.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appGoneToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
              
    }
    
    func updateViewWithPreferences(appPreferences: AppPrefferencesModel){
        self.timerView.setPreferences(preferences: appPreferences)
    }
    
    @objc func appGoneToBackground() {
        print("app in background!")
    }
    
    @objc func appCameToForeground() {
        print("app in foreground!")
        
        self.timerView.hasDeliveredNotification(callback: {itHas in
            if(itHas){
                self.timerDidFinishedInBackground()
            } else{
                self.timerDidUpdatedInBackground()
            }
        })
    }
    
    //we don't have any messages
    //timer can be still running, or state can be already handled
    private func timerDidUpdatedInBackground(){
        #warning("detect if timer is started (variable?)")
        
        // can be possible getting there after timer finished work, and it will be handled,
        // so wanted check if timer is stopped and finished
        
        // get ellapsed time
        // update timer util
        // get callback from timer util to update views
    }
    
    
    //we have delivered message, we have to notify timer about finish
    private func timerDidFinishedInBackground(){
        DispatchQueue.main.async {
            self.timerView.finishFromBackground()
            self.timerView.clearDeliveredNotifications()
        }
    }

}

extension TimerViewController: TimerViewDelegate{

    public func onTimeGone() {
        self.soundUtil?.play()
    }
    
}
