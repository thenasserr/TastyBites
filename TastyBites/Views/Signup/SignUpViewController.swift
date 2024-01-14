//
//  SignUpViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//

import UIKit
import ProgressHUD

class SignUpViewController: UIViewController {

  // MARK: - Outlets

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Additional setup after loading the view
  }

  // MARK: - Actions

  // Handles the create account button press
  @IBAction func creatAccountButtonPressed(_ sender: Any) {
    guard let name = nameTextField.text,
          let email = emailTextField.text,
          let password = passwordTextField.text else {
      return
    }

    if isDataInputValid() {
      // Attempt to register a new user with Firebase
      FirebaseUserListener.shared.registerNewUser(email: email, password: password, name: name) { [weak self] error in
        guard let self = self else { return }
        if error == nil {
          // Show success message if registration is successful
          ProgressHUD.showSuccess("Email Verification Sent, Please Verify Your Email")
        } else {
          // Show error message if registration fails
          ProgressHUD.showError(error?.localizedDescription)
        }
      }
    } else {
      // Show error message if input data is not valid
      ProgressHUD.showError("All Fields Are Required")
    }
  }

  // Handles the sign-in button press
  @IBAction func signinButtonPressed(_ sender: Any) {
    // Navigate to the login view controller
    let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    loginViewController.modalPresentationStyle = .fullScreen
    present(loginViewController, animated: true)
  }

  // MARK: - Private Methods

  // Checks if the input data is valid
  private func isDataInputValid() -> Bool {
    return !(nameTextField.text?.isEmpty ?? true)
    && !(passwordTextField.text?.isEmpty ?? true)
    && !(emailTextField.text?.isEmpty ?? true)
  }
}
