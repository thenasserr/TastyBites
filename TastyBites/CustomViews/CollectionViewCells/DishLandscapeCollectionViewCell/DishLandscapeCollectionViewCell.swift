//
//  DishLandscapeCollectionViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {

  static let identifier = String(describing: DishLandscapeCollectionViewCell.self)

  @IBOutlet weak var dishImageView: UIImageView!
  @IBOutlet weak var titleLable: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var caloriesLabel: UILabel!

  func setup(dish: Dish) {
    dishImageView.kf.setImage(with: dish.image?.asURL)
    titleLable.text = dish.name
    descriptionLabel.text = dish.description
    caloriesLabel.text = dish.formattedCalories
  }
}
