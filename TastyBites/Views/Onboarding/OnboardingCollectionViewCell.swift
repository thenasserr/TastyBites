//
//  OnboardingCollectionViewCell.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

  static let identifier = String(describing: OnboardingCollectionViewCell.self)
  
  @IBOutlet weak var slideImageView: UIImageView!
  @IBOutlet weak var slideTitleLabel: UILabel!
  @IBOutlet weak var slideDescription: UILabel!

  func setup(_ slide: OnboardingSlides) {
    slideImageView.image = slide.image
    slideTitleLabel.text = slide.title
    slideDescription.text = slide.description
  }

}
