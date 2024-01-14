//
//  GettingStartedViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//

import UIKit

class GettingStartedViewController: UIViewController {

  @IBOutlet weak var signupButton: UIButton!
  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    // Additional setup after loading the view
  }

  // MARK: - Actions

  // Handles the sign-in button press

  @IBAction func signinButtonPressed(_ sender: Any) {
    navigateToLogin()
  }


  @IBAction func signupButtonPressed(_ sender: Any) {
    navigateToSignup()
  }
  // MARK: - Private Methods

  // Navigates to the login view controller
  private func navigateToLogin() {
    let loginViewController = instantiateViewController(withIdentifier: "LoginViewController")
    present(loginViewController, animated: true)
  }

  // Navigates to the sign-up view controller
  private func navigateToSignup() {
    let signupViewController = instantiateViewController(withIdentifier: "SignUpViewController")
    present(signupViewController, animated: true)
  }

  // Instantiates a view controller from the storyboard with a given identifier
  private func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
    let viewController = storyboard?.instantiateViewController(withIdentifier: identifier)
    viewController?.modalPresentationStyle = .fullScreen
    return viewController!
  }
}
