//
//  productTableViewCell.swift
//  MachinTest
//
//  Created by STC on 01/09/23.
//

import UIKit

class productTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TitleLabel: UILabel!
        
    @IBOutlet weak var descriptionsLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
