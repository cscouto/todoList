//
//  TableViewCell.swift
//  StuffToDO
//
//  Created by Couto on 10/20/17.
//  Copyright © 2017 coutocode. All rights reserved.
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
