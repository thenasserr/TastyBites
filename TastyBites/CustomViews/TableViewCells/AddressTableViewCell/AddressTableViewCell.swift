//
//  AddressTableViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

  // MARK: - Properties

  /// A static identifier for the cell.
  static let identifier = String(describing: AddressTableViewCell.self)

  // MARK: - Outlets
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

  // MARK: - Setup Method
  
  /// Configure the cell with the provided address information.
  ///
  /// - Parameter address: The address model to display in the cell.
  func setup(address: Address) {
    nameLabel.text = address.name
    cityLabel.text = address.city
    streetLabel.text = address.street
  }

}
