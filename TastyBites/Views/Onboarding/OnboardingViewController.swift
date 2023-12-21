//
//  OnboardingViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 20/12/2023.
//

import UIKit

class OnboardingViewController: UIViewController {

  //MARK: - IBOutlet
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var pageControl: UIPageControl!

  //MARK: - Vars
  var slides: [OnboardingSlides] = []
  var currentPage = 0 {
    didSet {
      pageControl.currentPage = currentPage
      if currentPage == slides.count - 1 {
        nextButton.setTitle("Get Started", for: .normal)
      } else {
        nextButton.setTitle("Next", for: .normal)
      }
    }
  }
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    NetworkService.shared.myRequest()
    slides = [
      .init(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world.", image: UIImage(named: "slide1")!),
      .init(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: UIImage(named: "slide2")!),
      .init(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: UIImage(named: "slide3")!)
    ]
    pageControl.numberOfPages = slides.count
    }
  

  @IBAction func nextButtonPressed(_ sender: Any) {
    if currentPage == slides.count - 1 {
      let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNavigationC") as! UINavigationController
      controller.modalPresentationStyle = .fullScreen
      controller.modalTransitionStyle = .flipHorizontal
      present(controller, animated: true, completion: nil)
    } else {
      currentPage += 1
      let indexPath = IndexPath(item: currentPage, section: 0)
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
  }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return slides.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
    cell.setup(slides[indexPath.row])
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let width = scrollView.frame.width
    currentPage = Int(scrollView.contentOffset.x / width)
  }
}
