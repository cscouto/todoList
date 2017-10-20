//
//  TableViewCell.swift
//  ToDoBot
//
//  Created by Brett Romero on 4/24/16.
//  Copyright © 2016 tester. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var checkbox: UILabel!
    @IBOutlet var todoItem: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
