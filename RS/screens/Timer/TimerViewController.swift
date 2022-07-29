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
              
    }
    
    func updateViewWithPreferences(appPreferences: AppPrefferencesModel){
        self.timerView.setPreferences(preferences: appPreferences)
    }
    

    @objc func appCameToForeground() {
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            print("count: \(notifications.count)")
            if(notifications.count > 0){
                DispatchQueue.main.async {
                    self.timerView.finishFromBackground()
                    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                }
            }
        }
    }

}

extension TimerViewController: TimerViewDelegate{

    public func onTimeGone() {
        self.soundUtil?.play()
    }
    
}
