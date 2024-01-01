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
    guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces),
            !name.isEmpty else {
      ProgressHUD.showError("Please Enter Your Name")
      return
    }
    ProgressHUD.show("Placing Order...")

//    OrderAPI.shared.placeOrder(dishId: dish.id ?? "", name: name) { result in
//      switch result {
//      case .success(_):
//        ProgressHUD.showSuccess("Your order has been recevied. 👨‍🍳")
//      case .failure(let error):
//        ProgressHUD.showError(error.localizedDescription)
//      }
//    }



    NetworkService.shared.placeOrder(dishId: dish.id ?? "", name: name) { result in
      switch result {

      case .success(_):
        ProgressHUD.showSuccess("Your order has been recevied. 👨‍🍳")
      case .failure(let error):
        ProgressHUD.showError(error.localizedDescription)
      }
    }
  }
  
}
