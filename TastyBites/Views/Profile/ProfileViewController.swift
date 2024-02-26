//
//  ProfileViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 31/12/2023.
//

import UIKit

class ProfileViewController: UIViewController {

  // MARK: - Outlets

  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  // MARK: - Properties
  var titles: [String] = ["My Orders", "Wish List"]

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
      showUserInfo()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showUserInfo()
  }

  @IBAction func signoutPressed(_ sender: Any) {
    handleSignout()
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
}




