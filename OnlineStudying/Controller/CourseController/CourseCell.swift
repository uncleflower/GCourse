//
//  CourseCell.swift
//  OnlineStudying
//
//  Created by Jiehao Zhang on 2020/3/6.
//  Copyright © 2020 Jiehao Zhang. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
