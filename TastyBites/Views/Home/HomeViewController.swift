//
//  HomeViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import UIKit

class HomeViewController: UIViewController {

  //MARK: - Outlets
  @IBOutlet weak var categoryCollectionView: UICollectionView!

  //MARK: - Vars
  var categories: [DishCategory] = [
    .init(id: "id1", name: "Africa Dish1", image: "https://picsum.photos/200/300"),
    .init(id: "id1", name: "Africa Dish2", image: "https://picsum.photos/200/300"),
    .init(id: "id1", name: "Africa Dish3", image: "https://picsum.photos/200/300"),
    .init(id: "id1", name: "Africa Dish4", image: "https://picsum.photos/200/300"),
    .init(id: "id1", name: "Africa Dish5", image: "https://picsum.photos/200/300")
  ]
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    registerCells()
    }

  private func registerCells() {
    categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
    cell.setup(category: categories[indexPath.row])
    return cell
  }
}

