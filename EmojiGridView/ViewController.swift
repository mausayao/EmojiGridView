//
//  ViewController.swift
//  EmojiGridView
//
//  Created by Maurício de Freitas Sayão on 14/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let dataSource = DataSource()
    let delegate = EmojiCollectionViewDelegate(numberOfItemsPerRow: 6, interItemSpacing: 8)
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.allowsMultipleSelection = true
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isEditing && identifier == "ShowEmojiDetail" {
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowEmojiDetail",
              let emojiCell = sender as? EmojiCell,
              let emojiDetailContorller = segue.destination as? EmojiDetailController,
              let indexPath = collectionView.indexPath(for: emojiCell),
              let emoji = Emoji.shared.emoji(at: indexPath)
        else { fatalError() }
        
        emojiDetailContorller.emoji = emoji
    }
    
    @IBAction func addEmoji(_ sender: UIBarButtonItem) {
        let (category, randomEmoji) = Emoji.randomEmoji()
        dataSource.addEmoji(randomEmoji, to: category)
        
        let emojiCount = collectionView.numberOfItems(inSection: 0)
        let insertedIndex = IndexPath(item: emojiCount, section: 0)
        collectionView.insertItems(at: [insertedIndex])
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        deleteButton.isEnabled = isEditing
        addButton.isEnabled = !isEditing
        
        collectionView.indexPathsForVisibleItems.forEach { indexPath in
            guard let emojiCell = collectionView.cellForItem(at: indexPath) as? EmojiCell else { return }
            emojiCell.isEditing = editing
        }
        
        if !isEditing {
            collectionView.indexPathsForSelectedItems?.compactMap({ $0 }).forEach { indexPath in
                collectionView.deselectItem(at: indexPath, animated: true)
            }
        }
    }
    
    @IBAction func deleteEmoji(_ sender: UIBarButtonItem) {
        guard let selectedIndices = collectionView.indexPathsForSelectedItems else { return }
        
        let sectionsToDelete = Set(selectedIndices.map({ $0.section }))
        sectionsToDelete.forEach { section in
            let indexPathsForSection = selectedIndices.filter({$0.section == section})
            let sortedIndexPath = indexPathsForSection.sorted(by: {$0.item > $1.item})
            
            dataSource.deleteEmoji(at: sortedIndexPath)
            collectionView.deleteItems(at: sortedIndexPath)
        }
    }
}
