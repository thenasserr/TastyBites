//
//  OnboardingCollectionViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

  // MARK: - Constants

  // Reuse identifier for the cell
  static let identifier = "OnboardingCollectionViewCell"

  // MARK: - Outlets
  @IBOutlet weak var slideImageView: UIImageView!
  @IBOutlet weak var slideTitleLabel: UILabel!
  @IBOutlet weak var slideDescription: UILabel!

  // MARK: - Public Methods

  // Method to configure the cell with data from an OnboardingSlides instance
  func setup(_ slide: OnboardingSlides) {
    slideImageView.image = slide.image
    slideTitleLabel.text = slide.title
    slideDescription.text = slide.description
  }
}
