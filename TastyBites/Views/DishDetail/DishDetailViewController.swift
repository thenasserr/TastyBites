//
//  DishDetailViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import UIKit

class DishDetailViewController: UIViewController {

  //MARK: - IBOutlet
  @IBOutlet weak var dishImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var caloriesLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var nameTextField: UITextField!

  //MARK: - Vars
  var dish: Dish!

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    populateView()
    }
//MARK: - To Pobulate Data in DetailViewController
  private func populateView() {
    dishImageView.kf.setImage(with: dish.image?.asURL)
    titleLabel.text = dish.name
    caloriesLabel.text = dish.formattedCalories
    descriptionLabel.text = dish.description
  }

  @IBAction func placeOrderButtonPressed(_ sender: Any) {
  }
  
}
