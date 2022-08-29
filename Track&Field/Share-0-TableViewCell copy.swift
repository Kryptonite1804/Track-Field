//
//  History-0-TableViewCell.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/07/18.
//

import UIKit

class Share_0_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var date_Label: UILabel!
    @IBOutlet weak var menu_Label: UILabel!
    @IBOutlet weak var distance_Label: UILabel!
    @IBOutlet weak var point_Label: UILabel!
    @IBOutlet weak var pain_Label: UILabel!
    
    @IBOutlet weak var distance_Image: UIImageView!
    @IBOutlet weak var point_Image: UIImageView!
    @IBOutlet weak var pain_Image: UIImageView!
    @IBOutlet weak var background_Image: UIImageView!
    
    
    @IBOutlet weak var total_Label: UILabel!
    @IBOutlet weak var noData_Label: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
