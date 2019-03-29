//
//  BasePersonCell.swift
//  CoreDataModel
//
//  Created by 宋璞 on 2019/3/29.
//  Copyright © 2019 宋璞. All rights reserved.
//

import UIKit

class BasePersonCell: UITableViewCell {

    @IBOutlet weak var mPersonAgeLabel: UILabel!
    @IBOutlet weak var mPersonNameLabel: UILabel!
    
    var person: Person?{
        didSet{
            mPersonNameLabel.text = person!.name
            mPersonAgeLabel.text = "\(person!.age)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
