//
//  ListOrdersViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import UIKit

class ListOrdersViewController: UIViewController {

  //MARK: - OBOutlet
  @IBOutlet weak var tableView: UITableView!

  //MARK: - Vars
  var orders: [Order] = [
    .init(id: "id1", name: "Ibrahim Nasser", dish: .init(id: "id1", name: "Garri", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 566)),
    .init(id: "id1", name: "Hager Nasser", dish: .init(id: "id1", name: "Indomi", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 344)),
    .init(id: "id1", name: "Ahmed Ali", dish: .init(id: "id1", name: "Pizza", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 500)),
    .init(id: "id1", name: "Nada Nasser", dish: .init(id: "id1", name: "Spaguti", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 700))
  ]
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    title = "Orders"
    registerCells()
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
