//
//  CasinoViewController.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import UIKit

public final class CasinoViewController: UIViewController {
    
    
    private let presenter: CasinoPresenter
    
    private var soundUtil: SoundUtil? = nil
    
    fileprivate var datasourse = [Int]()
    
    fileprivate var currentSelectedIndex = 0
    
    @IBOutlet weak var doneButton: LabelWithCallBack!
    
    @IBOutlet weak var picker: SilintUIPickerView!
    
    @IBOutlet weak var rouleteView: RouleteView!
    
    @IBOutlet weak var hiddenView: UIView!
    
    @IBOutlet weak var rouleteDesctop: UIView!
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: CasinoPresenter) {
        self.presenter = presenter
        
        super.init(nibName: "CasinoViewController", bundle: Bundle.main)
    }
    
    
    public override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)

           self.soundUtil = getPlayer(sound: .Tink)
       }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hiddenView.alpha = 0.0
        self.datasourse = rouleteView.getDataSource()
        self.picker.dataSource = self
        self.picker.delegate = self
        self.picker.selectRow(currentSelectedIndex, inComponent: 0, animated: true)
        self.picker.setSoundsEnabled(false)
        
        rouleteView.isUserInteractionEnabled = true
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(CasinoViewController.handleTap(_:)))
        tapGR.delegate = self
        tapGR.numberOfTapsRequired = 3
        rouleteView.addGestureRecognizer(tapGR)
        
        self.doneButton.text = Translations.Casino.cheat
        self.doneButton.callback = {
            self.showHiddenView(value: true)
            self.rouleteView.targetIndex = self.currentSelectedIndex
        }
        
        self.rouleteView.delegate = self
        self.setGradientBackground()
        
        self.presenter.viewDidLoad()
    }
    
    private func showHiddenView(value: Bool){
        UIView.animate(withDuration: 1.5) {
                self.hiddenView.alpha = !value ? 1.0 : 0.0
        }
    }
    
    private func setGradientBackground() {
        
        guard let top = UIColor.topGB?.cgColor,
              let mid = UIColor.midGB?.cgColor,
              let bot = UIColor.bottomGB?.cgColor
        else {
            return
        }
        
        let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [top, mid, bot]
            gradientLayer.locations = [0.1, 0.5, 1.0]
            gradientLayer.frame = rouleteDesctop.bounds
                
        rouleteDesctop.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension CasinoViewController: UIPickerViewDataSource{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datasourse.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(datasourse[row])"
    }
}

extension CasinoViewController: UIGestureRecognizerDelegate {
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        self.showHiddenView(value: false)
    }
}

extension CasinoViewController: UIPickerViewDelegate{
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentSelectedIndex = row
        self.rouleteView.targetIndex = currentSelectedIndex
    }
}

extension CasinoViewController: RoleteViewDelegate{
    func onSectorDetected() {
        self.soundUtil?.play()
    }
}
