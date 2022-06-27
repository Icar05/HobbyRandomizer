//
//  MenuDataSource.swift
//  HobbyRandomizer
//
//  Created by ICoon on 07.06.2022.
//

import Foundation

enum ScreenTypes : String, CaseIterable{
    case Casino, Test, Create, Hobby, WorkInProgress, Todo, Files, Settings
}

protocol MenuDelegate: NSObject{
    func onItemSelected(item: ScreenTypes)
}

class MenuDataSource: NSObject,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    
    private var data: [MenuCellModel] = []
    
    private let identifier = String(describing: MenuCell.self)
    
    private let spacing: CGFloat = 4
    
    private weak var delegate: MenuDelegate? = nil
    
    
    func setDelegate(delegate: MenuDelegate){
        self.delegate = delegate
    }
    
    
    func setData(data: [MenuCellModel]){
        self.data = data
    }
    
    func getIdentifier() -> String{
        return self.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MenuCell
        
            cell.configure(model: self.data[indexPath.row])

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

extension MenuDataSource: UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.data[indexPath.row].type
        self.delegate?.onItemSelected(item: item)
    }
    
}
