//
//  ListDishesViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import UIKit
import ProgressHUD

class ListDishesViewController: UIViewController {

  //MARK: - IBOutlet
  @IBOutlet weak var tableView: UITableView!

  // MARK: - Properties
      var category: DishCategory!
      var dishes: [Dish] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      title = category.name
      registerCells()
      ProgressHUD.show()

      fetchDishesForCategory()
    }

  func fetchDishesForCategory() {
      ProgressHUD.show()

      ListDishesAPI.shared.getDishes(categoryId: category.id ?? "") { [weak self] result in
          switch result {
          case .success(let dishListResponse):
              self?.handleSuccessResponse(with: dishListResponse.data)
          case .failure(let error):
              self?.handleError(error)
          }
      }
  }

  // MARK: - Handle Success Response
  private func handleSuccessResponse(with dishes: [Dish]?) {
      ProgressHUD.dismiss()

      guard let dishes = dishes else {
          // Handle the case where dishes is nil or empty
          return
      }

      self.dishes = dishes
      self.tableView.reloadData()
  }

  // MARK: - Handle Error
  private func handleError(_ error: Error) {
      ProgressHUD.showError(error.localizedDescription)
      print(error.localizedDescription)
  }

  //MARK: - Register TableView Cells
  private func registerCells() {
    tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
  }


}

//MARK: - TableView Delegate and DataSource
extension ListDishesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dishes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as! DishListTableViewCell
    cell.setup(dish: dishes[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let controller = DishDetailViewController.instantiate()
    controller.dish = dishes[indexPath.row]
    navigationController?.pushViewController(controller, animated: true)
  }
}
