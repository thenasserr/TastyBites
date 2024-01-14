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

  // MARK: - Properties

  private var slides: [OnboardingSlides] = []
  private var currentPage: Int = 0 {
    didSet {
      updateUIForCurrentPage()
    }
  }

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupOnboardingSlides()
    setupUI()
  }

  // MARK: - Initial Setup

  private func setupOnboardingSlides() {
    slides = [
      OnboardingSlides(title: "Delicious Dishes",
                       description: "Experience a variety of amazing dishes from different cultures around the world.",
                       image: UIImage(named: "slide1")!),
      OnboardingSlides(title: "World-Class Chefs",
                       description: "Our dishes are prepared by only the best.",
                       image: UIImage(named: "slide2")!),
      OnboardingSlides(title: "Instant World-Wide Delivery",
                       description: "Your orders will be delivered instantly irrespective of your location around the world.",
                       image: UIImage(named: "slide3")!)
    ]
  }

  private func setupUI() {
    configurePageControl()
    configureNextButton()
  }

  private func configurePageControl() {
    pageControl.numberOfPages = slides.count
  }

  private func configureNextButton() {
    updateUIForCurrentPage()
  }

  // MARK: - UI Update

  private func updateUIForCurrentPage() {
    pageControl.currentPage = currentPage

    if currentPage == slides.count - 1 {
      nextButton.setTitle("Get Started", for: .normal)
    } else {
      nextButton.setTitle("Next", for: .normal)
    }
  }

  // MARK: - Button Action

  @IBAction func nextButtonPressed(_ sender: Any) {
    handleNextButtonAction()
  }


  // MARK: - Navigation

  private func handleNextButtonAction() {
    if currentPage == slides.count - 1 {
      navigateToGettingStarted()
    } else {
      moveToNextSlide()
    }
  }

  private func navigateToGettingStarted() {
    let gettingStartedController = storyboard?.instantiateViewController(withIdentifier: "GettingStartedViewController") as! GettingStartedViewController
    gettingStartedController.modalPresentationStyle = .fullScreen
    gettingStartedController.modalTransitionStyle = .flipHorizontal
    present(gettingStartedController, animated: true, completion: nil)
  }

  private func moveToNextSlide() {
    currentPage += 1
    let indexPath = IndexPath(item: currentPage, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }

}


// MARK: - CollectionView Delegate and DataSource

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

