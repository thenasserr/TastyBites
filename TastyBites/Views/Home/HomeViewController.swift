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
  @IBOutlet weak var popularColletionView: UICollectionView!
  @IBOutlet weak var specialsCollectionView: UICollectionView!
  //MARK: - Vars
  var categories: [DishCategory] = [
    .init(id: "id1", name: "Africa Dish1", image: "https://picsum.photos/200/300"),
    .init(id: "id1", name: "Africa Dish2", image: "https://picsum.photos/200/300"),
    .init(id: "id1", name: "Africa Dish3", image: "https://picsum.photos/200/300"),
    .init(id: "id1", name: "Africa Dish4", image: "https://picsum.photos/200/300"),
    .init(id: "id1", name: "Africa Dish5", image: "https://picsum.photos/200/300")
  ]

  var populars: [Dish] = [
    .init(id: "id", name: "Garri", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 123),
    .init(id: "id", name: "Indomi", description: "This is The Best Dish I have Ever taste This is The Best Dish I have Ever taste This is The Best Dish I have Ever taste This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 500),
    .init(id: "id", name: "Pizza", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 333),
    .init(id: "id", name: "Pizza", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 333),
    .init(id: "id", name: "Pizza", description: "This is The Best Dish I have Ever taste", image: "https://picsum.photos/200/300", calories: 333)
  ]

  var specials: [Dish] = [
    .init(id: "id", name: "Fried Plantain", description: "This is My Favourite Dish", image: "https://picsum.photos/200/300", calories: 123),
    .init(id: "id", name: "Beans and Garri", description: "This is My Favourite Dish", image: "https://picsum.photos/200/300", calories: 123)
  ]
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    registerCells()
    }

  private func registerCells() {
    categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)

    popularColletionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)

    specialsCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case categoryCollectionView:
      return categories.count
    case popularColletionView:
      return populars.count
    case specialsCollectionView:
      return specials.count
    default:
      return 0
    }
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    case categoryCollectionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
      cell.setup(category: categories[indexPath.row])
      return cell
    case popularColletionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
      cell.setup(dish: populars[indexPath.row])
      return cell
    case specialsCollectionView:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
      cell.setup(dish: specials[indexPath.row])
      return cell
    default:
      return UICollectionViewCell()
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == categoryCollectionView {

    } else {
      let controller = DishDetailViewController.instantiate()
      controller.dish = collectionView == popularColletionView ? populars[indexPath.row] : specials[indexPath.row]
      navigationController?.pushViewController(controller, animated: true)
    }
  }
}

