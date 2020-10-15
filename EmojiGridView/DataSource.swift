//
//  DataSource.swift
//  EmojiGridView
//
//  Created by Maurício de Freitas Sayão on 15/10/20.
//

import UIKit

class DataSource: NSObject, UICollectionViewDataSource {
    let emoji = Emoji.shared
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        emoji.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = emoji.sections[section]
        let emoji = self.emoji.data[category]
        
        return emoji?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else {
            fatalError("Cell cannot be created")
        }
        
        let category = emoji.sections[indexPath.section]
        let emoji = self.emoji.data[category]?[indexPath.item] ?? ""
        
        cell.emojiLabel.text = emoji
        
        return cell
    }
}
