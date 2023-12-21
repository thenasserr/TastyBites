//
//  ListOrdersViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import UIKit
import ProgressHUD

class ListOrdersViewController: UIViewController {

  //MARK: - OBOutlet
  @IBOutlet weak var tableView: UITableView!

  //MARK: - Vars
  var orders: [Order] = []
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    title = "Orders"
    registerCells()
    ProgressHUD.show()


  }

  override func viewDidAppear(_ animated: Bool) {
    NetworkService.shared.fetchOrders { [weak self] (result) in
      switch result {
      case .success(let orders):
        ProgressHUD.dismiss()

        self?.orders = orders
        self?.tableView.reloadData()
      case .failure(let error):
        ProgressHUD.showError(error.localizedDescription)
      }
    }
  }

  //MARK: - Register TableView Cells
  private func registerCells() {
    tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
  }
}

//MARK: - TableView Delegate and DataSource
extension ListOrdersViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return orders.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as! DishListTableViewCell
    cell.setup(order: orders[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let controller = DishDetailViewController.instantiate()
    controller.dish = orders[indexPath.row].dish
    navigationController?.pushViewController(controller, animated: true)
  }

}
