//
//  UISelectionDialog.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import UIKit

struct UISelectionDialogModel{
    let callback: (String) -> Void
    let title: String
}


class UISelectionDialog: UIViewController {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var indicatorView: UIView!
    
    @IBOutlet weak var cancelButton: UILabel!
    
    @IBOutlet weak var onButton: UILabel!
    
    @IBOutlet weak var container: UIView!
    
    private let model: UISelectionDialogModel
    
    private var completion: ((String)->Void?)? = nil
    
    
    
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
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        self.completion = model.callback
    }
    
    
    func setCompletion(completion: @escaping (String)->Void){
         self.completion = completion
     }
    
}

extension UISelectionDialog : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    
}
