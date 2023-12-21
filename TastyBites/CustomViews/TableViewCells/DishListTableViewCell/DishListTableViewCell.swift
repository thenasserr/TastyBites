//
//  DishListTableViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import UIKit

class DishListTableViewCell: UITableViewCell {

  static let identifier = String(describing: DishListTableViewCell.self)

    
  @IBOutlet weak var dishImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!

  func setup(dish: Dish) {
    dishImageView.kf.setImage(with: dish.image?.asURL)
    titleLabel.text = dish.name
    descriptionLabel.text = dish.description
  }

  func setup(order: Order) {
    dishImageView.kf.setImage(with: order.dish?.image?.asURL)
    titleLabel.text = order.dish?.name
    descriptionLabel.text = order.name
  }
}
