//
//  ContactUsTableViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit

class ContactUsTableViewCell: UITableViewCell {

  @IBOutlet weak var imgView: UIImageView!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  static let identifier = String(describing: ContactUsTableViewCell.self)


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  func setup(owner: ContactUs) {
    imgView.image = owner.image
    emailLabel.text = owner.email
    nameLabel.text = owner.name
    phoneLabel.text = owner.number
  }

}
