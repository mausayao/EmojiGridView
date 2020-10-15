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

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
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
}
