//
//  SettingsTableViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

  static let identifier = String(describing: SettingsTableViewCell.self)


  @IBOutlet weak var imgView: UIImageView!
  @IBOutlet weak var settingsLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
