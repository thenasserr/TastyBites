//
//  CategoryCollectionViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

  static let identifier = String(describing: CategoryCollectionViewCell.self)

  @IBOutlet weak var categoryImageView: UIImageView!
  @IBOutlet weak var categoryLabel: UILabel!

  func setup(category: DishCategory) {
    categoryImageView.kf.setImage(with: category.image?.asURL)
    categoryLabel.text = category.name
  }

}
