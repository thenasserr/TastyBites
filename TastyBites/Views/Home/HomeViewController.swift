//
//  HomeViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import UIKit
import ProgressHUD

class HomeViewController: UIViewController {

  //MARK: - Outlets
  @IBOutlet weak var categoryCollectionView: UICollectionView!
  @IBOutlet weak var popularColletionView: UICollectionView!
  @IBOutlet weak var specialsCollectionView: UICollectionView!
  //MARK: - Vars
  var categories: [DishCategory] = []
  var populars: [Dish] = []
  var specials: [Dish] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    registerCells()
    ProgressHUD.show()

    fetchData()
  }

  // Fetch Data
  private func fetchData() {
    CategoriesAPI.shared.getGategories { [weak self] result in
      switch result {
      case .success(let allDishes):
        ProgressHUD.dismiss()
        self?.categories = allDishes.data?.categories ?? []
        self?.populars = allDishes.data?.populars ?? []
        self?.specials = allDishes.data?.specials ?? []
        self?.updateCollectionViewData()
      case .failure(let error):
        print(error.localizedDescription)
        ProgressHUD.showError(error.localizedDescription)
      }
    }
  }

  // Update Collection Views
  private func updateCollectionViewData() {
    categoryCollectionView.reloadData()
    popularColletionView.reloadData()
    specialsCollectionView.reloadData()
  }




  //MARK: - Register CollectionView Cell
  private func registerCells() {
    categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)

    popularColletionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)

    specialsCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
  }
}


//MARK: - CollectionView Delegate and DataSource
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
      navigateToListDishesViewController(forCategoryAtIndex: indexPath.row)
    } else {
      let controller = DishDetailViewController.instantiate()
      controller.dish = collectionView == popularColletionView ? populars[indexPath.row] : specials[indexPath.row]
      navigationController?.pushViewController(controller, animated: true)
    }
  }
}

// MARK: - Navigation
extension HomeViewController {
    func navigateToListDishesViewController(forCategoryAtIndex index: Int) {
        let controller = ListDishesViewController.instantiate()
        controller.category = categories[index]
        navigationController?.pushViewController(controller, animated: true)
    }

    func navigateToDishDetailViewController(forDish dish: Dish) {
        let controller = DishDetailViewController.instantiate()
        controller.dish = dish
        navigationController?.pushViewController(controller, animated: true)
    }
}





