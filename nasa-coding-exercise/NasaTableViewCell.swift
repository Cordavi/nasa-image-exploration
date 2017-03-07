//
//  NasaTableViewCell.swift
//  nasa-coding-exercise
//
//  Created by Michael Amundsen on 9/26/16.
//  Copyright © 2016 Michael Amundsen. All rights reserved.
//

import UIKit

class NasaTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nasaImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
