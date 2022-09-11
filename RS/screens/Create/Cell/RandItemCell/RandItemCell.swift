//
//  RandItemCell.swift
//  HobbyRandomizer
//
//  Created by ICoon on 08.06.2022.
//

import UIKit

class RandItemCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
            
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var statusImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: RandItemCellModel){
        self.title.text = model.title
        self.icon.setImageColor(color: model.type.getColorForType())
        
        model.subTitle.isReachable{ success in
            if success {
                self.subTitle.attributedText = model.subTitle.httpString(
                    color: model.type.getColorForType(),
                    size: 14
                )
            } else {
                self.subTitle.text = model.subTitle
            }
        }
    }
    
    
}

extension String{
    func isReachable(completion: @escaping (Bool) -> ()) {
        
        guard let url = URL(string: self) else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
            request.httpMethod = "HEAD"
        
        URLSession.shared.dataTask(with: request) { _, response, _ in
            DispatchQueue.main.async {
                completion((response as? HTTPURLResponse)?.statusCode == 200)
            }
        }.resume()
    }
    
    
    func httpString(color: UIColor, size: CGFloat) -> NSAttributedString{
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.boldSystemFont(ofSize: size)
        ]
        
        return NSAttributedString(string: self, attributes: strokeTextAttributes)
    }
}
