//
//  CategoryCollectionViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties

      /// A static identifier for the cell.
      static let identifier = String(describing: CategoryCollectionViewCell.self)

      // MARK: - Outlets

  @IBOutlet weak var categoryImageView: UIImageView!
  @IBOutlet weak var categoryLabel: UILabel!

  // MARK: - Setup Method

      /// Configure the cell with the provided category information.
      ///
      /// - Parameter category: The DishCategory model to display in the cell.
      func setup(category: DishCategory) {
          categoryImageView.kf.setImage(with: category.image?.asURL)
          categoryLabel.text = category.name
      }
  }

