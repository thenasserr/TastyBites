//
//  DishDetailViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import UIKit
import ProgressHUD

class DishDetailViewController: UIViewController {

  //MARK: - IBOutlet
  @IBOutlet weak var dishImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var caloriesLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var nameTextField: UITextField!

  // MARK: - Properties
  var dish: Dish!

  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  // MARK: - UI Setup
  private func setupUI() {
    populateView()
  }

  // MARK: - Populate View
  private func populateView() {
    dishImageView.kf.setImage(with: dish.image?.asURL)
    titleLabel.text = dish.name
    caloriesLabel.text = dish.formattedCalories
    descriptionLabel.text = dish.description
  }

  // MARK: - Place Order Button Action
  @IBAction func placeOrderButtonPressed(_ sender: Any) {
    guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
      ProgressHUD.showError("Please Enter Your Name")
      return
    }
    ProgressHUD.show("Placing Order...")

    NetworkService.shared.placeOrder(dishId: dish.id ?? "", name: name) { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(_):
        ProgressHUD.showSuccess("Your order has been received. 👨‍🍳")
      case .failure(let error):
        ProgressHUD.showError(error.localizedDescription)
      }
    }
  }
}
