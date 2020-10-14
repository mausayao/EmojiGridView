//
//  EmojiDetailController.swift
//  EmojiGridView
//
//  Created by Maurício de Freitas Sayão on 14/10/20.
//

import UIKit

class EmojiDetailController: UIViewController {
    
    var emoji: String? {
        didSet {
            if let label = textLabel {
                label.text = emoji
            }
        }
    }
    
    @IBOutlet weak var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = emoji
    }

}
