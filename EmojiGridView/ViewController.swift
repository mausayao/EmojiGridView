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

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
    }
}
