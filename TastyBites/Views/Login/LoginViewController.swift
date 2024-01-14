//
//  LoginViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 22/12/2023.
//

import UIKit
import ProgressHUD

class LoginViewController: UIViewController {

  // MARK: - Outlets

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    // Additional setup after loading the view
  }

  // MARK: - Actions

  @IBAction func loginButtonPressed(_ sender: Any) {
    guard let email = emailTextField.text, let password = passwordTextField.text else {
      return
    }

    if isDataInputValid(mode: .login) {
      FirebaseUserListener.shared.loginUser(email: email, password: password) { [weak self] error, isEmailVerified in
        if error == nil {
          if isEmailVerified {
            self?.navigateToHome()
          } else {
            ProgressHUD.showError("Please check your email and verify your registration")
          }
        } else {
          ProgressHUD.showError(error?.localizedDescription)
        }
      }
    } else {
      ProgressHUD.showError("All Fields Are Required")
    }
  }

  //MARK: - Check Validation
  private func isDataInputedFor(mode: String) -> Bool {
    switch mode {
    case "login":
      return passwordTextField.text != "" && emailTextField.text != ""
    case "forgetPassword":
      return emailTextField.text != ""

    default:
      return false
    }

  }


  @IBAction func forgetPasswordButtonPressed(_ sender: Any) {
    if isDataInputValid(mode: .forgetPassword) {
      FirebaseUserListener.shared.resetPassword(email: emailTextField.text!) { error in
        if error == nil {
          ProgressHUD.showSuccess("Reset password email has been sent")
        } else {
          ProgressHUD.showError(error?.localizedDescription)
        }
      }
    } else {
      ProgressHUD.showError("Email Field Is Required")
    }
  }

  @IBAction func signupButtonPressed(_ sender: Any) {
    navigateToSignup()
  }

  // MARK: - Private Methods

  private enum InputMode {
    case login
    case forgetPassword
  }

  private func isDataInputValid(mode: InputMode) -> Bool {
    switch mode {
    case .login:
      return !(passwordTextField.text?.isEmpty ?? true) && !(emailTextField.text?.isEmpty ?? true)
    case .forgetPassword:
      return !(emailTextField.text?.isEmpty ?? true)
    }
  }


  private func navigateToHome() {
    let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationC") as! UITabBarController
    homeViewController.modalPresentationStyle = .fullScreen
    homeViewController.modalTransitionStyle = .flipHorizontal
    present(homeViewController, animated: true, completion: nil)
  }

  private func navigateToSignup() {
    let signupViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
    signupViewController.modalPresentationStyle = .fullScreen
    present(signupViewController, animated: true)
  }
}
