//
//  ListDishesViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import UIKit

class ListDishesViewController: UIViewController {

  //MARK: - IBOutlet
  @IBOutlet weak var tableView: UITableView!

  //MARK: - Vars
  var category: DishCategory!
  var dishes: [Dish] = [
    .init(id: "id", name: "Garri", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 123),
    .init(id: "id", name: "Indomi", description: "This is The Best Dish I have Ever taste This is The Best Dish I have Ever taste This is The Best Dish I have Ever taste This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 500),
    .init(id: "id", name: "Pizza", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 333),
    .init(id: "id", name: "Pizza", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 333),
    .init(id: "id", name: "Pizza", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 333)
  ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      title = category.name
      registerCells()
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
