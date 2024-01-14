//
//  DishListTableViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import UIKit

class DishListTableViewCell: UITableViewCell {

  // MARK: - Properties

  /// A static identifier for the cell.
  static let identifier = String(describing: DishListTableViewCell.self)

  // MARK: - Outlets

  @IBOutlet weak var dishImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!

  // MARK: - Setup Methods

  /// Configure the cell with the provided dish information.
  ///
  /// - Parameter dish: The Dish model to display in the cell.
  func setup(dish: Dish) {
    dishImageView.kf.setImage(with: dish.image?.asURL)
    titleLabel.text = dish.name
    descriptionLabel.text = dish.description
  }

  /// Configure the cell with the provided order information.
  ///
  /// - Parameter order: The Order model to display in the cell.
  func setup(order: Order) {
    dishImageView.kf.setImage(with: order.dish?.image?.asURL)
    titleLabel.text = order.dish?.name
    descriptionLabel.text = order.name
  }
}
