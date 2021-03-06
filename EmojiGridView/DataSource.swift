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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let emojiHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiHeaderView.reuseIdentifier, for: indexPath) as? EmojiHeaderView else {
            fatalError("Cannot create the session")
        }
        
        emojiHeader.textLabel.text = emoji.sections[indexPath.section].rawValue
        
        return emojiHeader
    }
}

extension DataSource {
    func addEmoji(_ emoji: String, to category: Emoji.Category) {
        guard var emojiData = self.emoji.data[category] else { return }
        emojiData.append(emoji)
        
        self.emoji.data.updateValue(emojiData, forKey: category)
    }
    
    func deleteEmoji(at indexPath: IndexPath) {
        let category = emoji.sections[indexPath.section]
        guard var emojiData = emoji.data[category] else { return }
        emojiData.remove(at: indexPath.item)
        
        emoji.data.updateValue(emojiData, forKey: category)
    }
    
    func deleteEmoji(at indexPaths: [IndexPath]) {
        indexPaths.forEach {
            deleteEmoji(at: $0)
        }
    }
}
