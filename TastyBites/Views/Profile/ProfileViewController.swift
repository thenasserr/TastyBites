//
//  ProfileViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 31/12/2023.
//

import UIKit

class ProfileViewController: UIViewController {

  // MARK: - Outlets

  @IBOutlet weak var tabelView: UITableView!
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  // MARK: - Properties
  var titles: [String] = ["My Orders", "Wish List"]

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showUserInfo()
  }

  @IBAction func signoutPressed(_ sender: Any) {
    handleSignout()
  }

  @IBAction func aboutButtonPressed(_ sender: Any) {
    navigateToAbout()
  }

  @IBAction func settingsPressed(_ sender: Any) {
    navigateToSettings()
  }

  // MARK: - Private Methods

  /// Displays user information in the UI.
  private func showUserInfo() {
    if let user = UserModel.currentUser {
      nameLabel.text = user.name
      // Load user image if needed
    }
  }

  /// Handles the signout process and navigates to the login screen.
  private func handleSignout() {
    FirebaseUserListener.shared.logOutUser { [weak self] error in
      if error == nil {
        let loginView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        DispatchQueue.main.async {
          loginView.modalPresentationStyle = .fullScreen
          self?.present(loginView, animated: true)
        }
      }
    }
  }

  /// Navigates to the 'About' screen.
  private func navigateToAbout() {
    let aboutViewController = AboutViewController.instantiate()
    aboutViewController.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(aboutViewController, animated: true)
  }

  /// Navigates to the 'Settings' screen.
  private func navigateToSettings() {
    let settingsViewController = SettingsViewController.instantiate()
    navigationController?.pushViewController(settingsViewController, animated: true)
  }
}




