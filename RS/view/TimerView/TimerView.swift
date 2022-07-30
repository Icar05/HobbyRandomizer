//
//  TimerView.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

public protocol TimerViewDelegate: NSObject{
    func actionButtonDidTap(needTimerStart: Bool)
}

let DEFAULT_MAX_TIME = 30

@IBDesignable
class TimerView: UIView {

    
    
    private var displayView: TimerDisplay = TimerDisplayLayerView()
    
    private var sizeOfView: CGFloat = 250
    
    private var clockLabel: UILabel = UILabel()
    
    private var actonLabel: UILabel = UILabel()
    
    private var elapsedLabel: UILabel = UILabel()
    
    private var isTimerStarted = false
    
    private var maxTimeInMinutes = DEFAULT_MAX_TIME
        
    weak var delegate: TimerViewDelegate? = nil
    
    
    @IBInspectable var outColor: UIColor  = UIColor.black {
        didSet{
            self.updateOutColor()
            self.displayView.updateCircleColor(color: outColor)
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
            self.setEllaptionLabelPosition()
        }
    }
    
    func restoreState(state: TimerUtilState){
        self.isTimerStarted = state.isStarted
        self.actonLabel.attributedText = getActionTextAttributes()
        self.maxTimeInMinutes = state.maxTime
        self.displayView.setSingleUpdaterColor(value: state.singleUpdateColor)
        self.displayView.setMaxTimeInSeconds(maxTimeInSeconds: maxTimeInMinutes.toSeconds())
        self.updateClocklabel(value: maxTimeInMinutes.toSeconds())
    }
    
    func onTimerStop() {
        self.updateClocklabel(value: maxTimeInMinutes.toSeconds())
        self.displayView.updateCurrentValue(current: 0, max: maxTimeInMinutes.toSeconds())
        self.isTimerStarted = false
        self.actonLabel.attributedText = getActionTextAttributes()
    }
    
    func onTimerUpdate(value: Int) {
        self.updateClocklabel(value: value)
        self.displayView.updateCurrentValue(current: value, max: maxTimeInMinutes.toSeconds())
    }
    
    func onTimerFinished() {
        self.isTimerStarted = false
        self.actonLabel.attributedText = getActionTextAttributes()
    }
    
    fileprivate func setup(){
        
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(displayView)
        self.addSubview(clockLabel)
        self.addSubview(actonLabel)
        self.addSubview(elapsedLabel)
                
        self.setupClockLabel()
        self.setupActionLabel()
        self.setupDisplayView()
        self.setupElapsedLabel()
    }
    
    func updateElapsedLabel(value: String){
        self.elapsedLabel.text = value
    }
    
    fileprivate func setupDisplayView(){
        self.displayView.updateCircleColor(color: outColor)
    }
    
    fileprivate func updateOutColor(){
        self.actonLabel.attributedText = getActionTextAttributes()
        self.clockLabel.textColor = outColor
    }
    
    fileprivate func setupElapsedLabel(){
        let fontSize = sizeOfView / 20
        let actionWidth = sizeOfView / 1.5
        let actionHeight = sizeOfView / 10
    
        self.elapsedLabel.textColor = UIColor.red
        self.elapsedLabel.frame =  CGRect(x: 0, y: 0, width: actionWidth, height: actionHeight)
        self.elapsedLabel.textAlignment = .center
        self.elapsedLabel.font = UIFont(name: elapsedLabel.font.familyName, size: fontSize)
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
        let textColor = isTimerStarted ? UIColor.colorMain : outColor
        
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: textColor ?? outColor,
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
    
    fileprivate func setEllaptionLabelPosition(){
        self.elapsedLabel.center.x = self.center.x
        self.elapsedLabel.center.y = self.sizeOfView / 4
    }

    fileprivate func updateClocklabel(value: Int){
        let time: (Int, Int) = secondsToHoursMinutesSeconds(value)
        let minutes = numToString(value: time.0)
        let seconds = numToString(value: time.1)
        self.clockLabel.text = "\(minutes):\(seconds)"
    }
    
    fileprivate func numToString(value: Int) -> String{
        return (value < 10) ? "0\(value)" : "\(value)"
    }
    
    fileprivate func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer? = nil){
        self.isTimerStarted = !isTimerStarted
        self.actonLabel.attributedText = getActionTextAttributes()
        self.delegate?.actionButtonDidTap(needTimerStart: isTimerStarted)
    }
}

