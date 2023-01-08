//
//  History-1-TableViewCell.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/07/18.
//
//なし

import UIKit

class History_1_TableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var number_Label: UILabel!
    @IBOutlet weak var distance_TF: UITextField!
    @IBOutlet weak var time_Label: UILabel!
    @IBOutlet weak var pace_Label: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
