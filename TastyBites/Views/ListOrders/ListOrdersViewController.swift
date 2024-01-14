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
  private var orders: [Order] = []
  private var isLoading = false

  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Orders"
    registerCells()
    fetchData()
  }

  //MARK: - Fetch Orders
  private func fetchData() {
    guard !isLoading else { return }
    isLoading = true
    ProgressHUD.show()

    OrderAPI.shared.fetchOrders { [weak self] result in
      self?.handleFetchResult(result)
    }
  }

  private typealias FetchResult = Result<BaseResponse<[Order]>, Error>

  private func handleFetchResult(_ result: FetchResult) {
    isLoading = false
    ProgressHUD.dismiss()

    switch result {
    case .success(let ordersResponse):
      if let data = ordersResponse.data {
        self.orders = data
        tableView.reloadData()
      }
    case .failure(let error):
      ProgressHUD.showError(error.localizedDescription)
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
    print(indexPath.row)
    let controller = DishDetailViewController.instantiate()
    controller.dish = orders[indexPath.row].dish
    navigationController?.pushViewController(controller, animated: true)
  }

}
