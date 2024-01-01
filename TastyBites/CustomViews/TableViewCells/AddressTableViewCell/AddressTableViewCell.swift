//
//  AddressTableViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

//  weak var delegate: BackWithAddress?
//  
//  func back(address: [Address]) {
//    nameLabel.text = address[0].name
//    cityLabel.text = address[0].city
//    streetLabel.text = address[0].street
//  }


  static let identifier = String(describing: AddressTableViewCell.self)

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var streetLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


//  func setup(address: Address) {
//    nameLabel.text = address.name
//    cityLabel.text = address.city
//    streetLabel.text = address.street
//  }

}
