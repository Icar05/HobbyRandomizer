//
//  TimerView.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

public protocol TimerViewDelegate: NSObject{
    func onTimeGone()
}


@IBDesignable
class TimerView: UIView {

    
    
    private var displayView: TimerDisplayView = TimerDisplayView()
    
    private let timerUtil: TimerUtil = TimerUtil()
    
    private var sizeOfView: CGFloat = 250
    
    private var clockLabel: UILabel = UILabel()
    
    private var actonLabel: UILabel = UILabel()
    
    private var isTimerStarted = false
    
    private var maxTimeInMinutes = 30
        
    weak var delegate: TimerViewDelegate? = nil
    
    
    @IBInspectable var outColor: UIColor  = UIColor.black {
        didSet{
            self.updateOutColor()
            self.displayView.updateOutColor(color: outColor)
        }
    }
 
    @IBInspectable var innerColor: UIColor  = UIColor.white {
        didSet{
            self.displayView.updateInnerColor(color: outColor)
        }
    }

    
    override func prepareForInterfaceBuilder(){
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    override var bounds: CGRect {
        didSet {
            self.frame = CGRect(x: 0, y: 0, width: sizeOfView, height: sizeOfView)
            self.displayView.center = self.center
            self.clockLabel.center = self.center
            self.setActionLabelPosition()
        }
    }
    
    func setPreferences(preferences: AppPrefferencesModel){
        self.maxTimeInMinutes = preferences.timerMinutes
        self.timerUtil.setMaxTime(maxTimeInMinutes: maxTimeInMinutes)
        self.displayView.setPreferences(preferences: preferences)
        self.updateClocklabel(value: maxTimeInMinutes.toSeconds())
    }
    
    
    fileprivate func setup(){
        
        self.timerUtil.delegate = self
        
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(displayView)
        self.addSubview(clockLabel)
        self.addSubview(actonLabel)
        
        self.timerUtil.setMaxTime(maxTimeInMinutes: maxTimeInMinutes)
        self.displayView.setMaxTimeInSeconds(maxTimeInSeconds: maxTimeInMinutes.toSeconds())
        
        self.setupClockLabel()
        self.setupActionLabel()
        self.setupDisplayView()
    }
    
    fileprivate func setupDisplayView(){
        self.displayView.updateOutColor(color: outColor)
    }
    
    fileprivate func updateOutColor(){
        self.actonLabel.attributedText = getActionTextAttributes()
        self.clockLabel.textColor = outColor
    }
    
    fileprivate func setupActionLabel(){
        let fontSize = sizeOfView / 10
        let actionWidth = sizeOfView / 3
        let actionHeight = sizeOfView / 10
        
        self.actonLabel.frame =  CGRect(x: 0, y: 0, width: actionWidth, height: actionHeight)
        self.actonLabel.textAlignment = .center
        self.actonLabel.font = UIFont(name: actonLabel.font.familyName, size: fontSize)
        self.actonLabel.attributedText = getActionTextAttributes()
        self.actonLabel.isUserInteractionEnabled = true
        self.actonLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
    }
    
    fileprivate func getActionTextAttributes() -> NSAttributedString{
        let text = isTimerStarted ? Translations.Timer.stopTimerText: Translations.Timer.startTimerText
        
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: outColor,
            .foregroundColor: UIColor.white,
            .strokeWidth: -5.0
        ]
        return NSAttributedString(string: text, attributes: strokeTextAttributes)
    }

    fileprivate func setupClockLabel(){
        let fontSize = sizeOfView / 6
        let clockWidth = sizeOfView / 1.5
        let clockHeight = sizeOfView / 5
        
        self.clockLabel.frame =  CGRect(x: 0, y: 0, width: clockWidth, height: clockHeight)
        self.clockLabel.textAlignment = .center
        self.clockLabel.textColor = outColor
        self.clockLabel.font = UIFont(name: "DBLCDTempBlack", size: fontSize)
        self.updateClocklabel(value: maxTimeInMinutes.toMinutes())
    }
    
    fileprivate func setActionLabelPosition(){
        let marginBottom = self.sizeOfView / 4
        self.actonLabel.center.x = self.center.x
        self.actonLabel.center.y = self.frame.size.height - marginBottom
    }

    fileprivate func updateClocklabel(value: Int){
        let time: (Int, Int) = secondsToHoursMinutesSeconds(value)
        let minutes = numToString(value: time.0)
        let seconds = numToString(value: time.1)
        self.clockLabel.text = "\(minutes):\(seconds)"
    }
    
    func numToString(value: Int) -> String{
        return (value < 10) ? "0\(value)" : "\(value)"
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func finishFromBackground(){
        self.timerUtil.stopTimer()
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer? = nil){
        self.isTimerStarted ? timerUtil.stopTimer() : timerUtil.startTimer()
        self.isTimerStarted = !isTimerStarted
        self.actonLabel.attributedText = getActionTextAttributes()
    }
    
}

extension TimerView: TimerUtilDelegate{
    
    
    func onTimerStop() {
        self.updateClocklabel(value: maxTimeInMinutes.toSeconds())
        self.displayView.updateCurrentValue(value: 0)
        self.isTimerStarted = false
        self.actonLabel.attributedText = getActionTextAttributes()
    }
    
    func onTimerUpdate(value: Int) {
        self.updateClocklabel(value: value)
        self.displayView.updateCurrentValue(value: value)
    }
    
    func onTimerFinished() {
        self.isTimerStarted = false
        self.actonLabel.attributedText = getActionTextAttributes()
        self.delegate?.onTimeGone()
    }
    
    
}
