//
//  JobCell.swift
//  Internship Posting App
//
//  Created by Bailey Ilagan on 8/3/17.
//  Copyright © 2017 Bailey Ilagan. All rights reserved.
//

import UIKit

protocol SaveButtonDelegate {
    
    func saveButtonClick (at index: IndexPath)
    
}

class JobCell: UITableViewCell {

    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    var index: IndexPath!
    var delegate: SaveButtonDelegate!
    
    @IBAction func saveButtonAction (_ sender:UIButton) {
        self.delegate.saveButtonClick(at: index)
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


