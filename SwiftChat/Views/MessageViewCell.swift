//
//  MessageViewCell.swift
//  SwiftChat
//
//  Created by Akdag on 27.02.2021.
//

import UIKit

class MessageViewCell: UITableViewCell {
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
