//
//  ReloadReportCell.swift
//  RS
//
//  Created by Галяткин Александр on 26.01.2023.
//

import UIKit

class ReloadReportCell: UITableViewCell, ReportCell {
    
    
    
    private var callback: (() -> Void )? = nil
    
    
    @IBOutlet weak var tryAgainLabel: UILabel!
    
    @IBOutlet weak var tryAgainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareBorder()
        self.tryAgainLabel.isUserInteractionEnabled = true
        self.tryAgainLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with model: ReportModel) {
        
        guard let m = model as? ReloadReportCellModel else {
            return
        }
        self.tryAgainLabel.text = Translations.Settings.randomReport
        self.callback  = m.callback
    }
    
    
    private func prepareBorder(){
        self.tryAgainView.layer.masksToBounds = true
        self.tryAgainView.translatesAutoresizingMaskIntoConstraints = false
        self.tryAgainView.layer.borderColor = UIColor.colorMain?.cgColor
        self.tryAgainView.layer.borderWidth = 1
    }
    
    
    @objc func onTap(_ sender: UITapGestureRecognizer? = nil){
        self.callback?()
    }

}
