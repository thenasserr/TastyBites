//
//  DishLandscapeCollectionViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties

  /// A static identifier for the cell.
  static let identifier = String(describing: DishLandscapeCollectionViewCell.self)

  // MARK: - Outlets
  @IBOutlet weak var dishImageView: UIImageView!
  @IBOutlet weak var titleLable: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var caloriesLabel: UILabel!

  // MARK: - Setup Method

      /// Configure the cell with the provided dish information.
      ///
      /// - Parameter dish: The Dish model to display in the cell.
      func setup(dish: Dish) {
          dishImageView.kf.setImage(with: dish.image?.asURL)
          titleLable.text = dish.name
          descriptionLabel.text = dish.description
          caloriesLabel.text = dish.formattedCalories
      }
  }
