//
//  TodosCells.swift
//  First Project To Do List
//
//  Created by Omar Tharwat on 3/7/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit

class TodosCells: UITableViewCell {

    @IBOutlet weak var DateTodos: UILabel!
    @IBOutlet weak var ContentTodos: UILabel!
    @IBOutlet weak var imageTodos: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
