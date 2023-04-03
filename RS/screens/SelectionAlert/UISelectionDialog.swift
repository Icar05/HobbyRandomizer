//
//  UISelectionDialog.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import UIKit

struct UISelectionDialogModel{
    let callback: (_ newColor: Color) -> Void
    let title: String
    let curentColor: Color
}

class UISelectionDialog: BaseDialogViewController {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var indicatorView: UIView!
    
    @IBOutlet weak var cancelButton: UILabel!
    
    @IBOutlet weak var onButton: UILabel!
    
    @IBOutlet weak var container: UIView!
    
    private let model: UISelectionDialogModel
    
    private var soundUtil: SoundUtil? = nil
   
    private var callback: ((_ newColor: Color) -> Void)? = nil

    private let colors: [Color] = [
        Color.init(uiColor: UIColor.red),
        Color.init(uiColor: UIColor.coolRed!),
        Color.init(uiColor: UIColor.coolOrange!),
        Color.init(uiColor: UIColor.orange),
        Color.init(uiColor: UIColor.yellow),
        Color.init(uiColor: UIColor.lightGreen!),
        Color.init(uiColor: UIColor.coolGreen!),
        Color.init(uiColor: UIColor.colorMain!),
        Color.init(uiColor: UIColor.lightBlue!),
        Color.init(uiColor: UIColor.blue),
        Color.init(uiColor: UIColor.purple),
        Color.init(uiColor: UIColor.colorCoolViolet!),
        Color.init(uiColor: UIColor.colorBorderGray!),
        Color.init(uiColor: UIColor.colorCappuccino!),
        Color.init(uiColor: UIColor.colorCocoa!)
    ]
    

    private var selectedRow = 0
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(model: UISelectionDialogModel) {
        self.model = model
        
        super.init(nibName: "UISelectionDialog", bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    
    func setupView() {
        self.container.layer.cornerRadius = 10
        self.setupPicker()
        self.setupButtons()
        self.setupExtra()
    }
    
    func setupExtra(){
        self.indicatorView.backgroundColor = model.curentColor.uiColor
        self.callback = model.callback
        self.titleLabel.text =  "\(Translations.SelectColor.selectColorTitle) \(model.title)"
    }
    
    func setupPicker(){
        self.selectedRow = colors.firstIndex(of: model.curentColor) ?? 0
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.selectRow(selectedRow, inComponent: 0, animated: true)
    }
    
    func setupButtons(){
        self.onButton.text = Translations.Permission.ok
        self.cancelButton.text = Translations.Permission.cancel
        self.onButton.isUserInteractionEnabled = true
        self.cancelButton.isUserInteractionEnabled = true
        self.onButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onOk(_:))))
        self.cancelButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onCancel(_:))))
    }
    
    func setCompletion(completion: @escaping (_ newColor: Color) -> Void){
         self.callback = completion
     }
    
    
    @objc func onCancel(_ sender: UITapGestureRecognizer? = nil){
        self.didTapButton()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onOk(_ sender: UITapGestureRecognizer? = nil){
        self.didTapButton()
        let color = Color.init(uiColor: indicatorView.backgroundColor!)
        self.callback?(color)
        self.dismiss(animated: true, completion: nil)
    }
    
    func didTapButton() {
        self.soundUtil = getAppComponent().getSoundUtil(sound: SoundCaf.actionSound())
        self.soundUtil?.play()
    }
}

extension UISelectionDialog : UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(colors[row].getName())"
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let color = self.colors[row]
        self.indicatorView.backgroundColor = color.uiColor
    }
}
