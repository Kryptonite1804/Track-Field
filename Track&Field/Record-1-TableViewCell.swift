//
//  Record-1-TableViewCell.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/07/18.
//

import UIKit

class Record_1_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var number_Label: UILabel!
    @IBOutlet weak var distance_TF: UITextField!
    @IBOutlet weak var time_TF: UITextField!
    @IBOutlet weak var pace_TF: UITextField!
    
    var timeTableView_PV = UIPickerView()
    var paceTableView_PV = UIPickerView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    

}
