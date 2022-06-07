//
//  MenuDataSource.swift
//  HobbyRandomizer
//
//  Created by ICoon on 07.06.2022.
//

import Foundation

class MenuDataSource: NSObject,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    
    private var dataSourse: [MenuCellModel] = []
    
    private let identifier = String(describing: MenuCell.self)
    
    private let spacing: CGFloat = 14
    
    
    
    func setDataSource(dataSource: [MenuCellModel]){
        self.dataSourse = dataSource
    }
    
    func getIdentifier() -> String{
        return self.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSourse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MenuCell
        
            cell.configure(model: self.dataSourse[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = (Int(collectionView.bounds.width) - (Int(spacing) * 2)) / 3
        return CGSize(width: cellSize, height: cellSize)

    }
    
}
