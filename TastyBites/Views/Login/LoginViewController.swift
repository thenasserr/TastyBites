//
//  LoginViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 22/12/2023.
//

import UIKit
import ProgressHUD

class LoginViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    
    }

  //MARK: - Login User
  @IBAction func loginButtonPressed(_ sender: Any) {
    guard let email = emailTextField.text,
          let password = passwordTextField.text else {
      return
    }
    if isDataInputedFor(mode: "login") {
      FirebaseUserListener.shared.loginUser(email: email, password: password) { [weak self] error, isEmailVerified in
        if error == nil {
          if isEmailVerified {
            let controller = self?.storyboard?.instantiateViewController(withIdentifier: "HomeNavigationC") as! UITabBarController
                  controller.modalPresentationStyle = .fullScreen
                  controller.modalTransitionStyle = .flipHorizontal
            self?.present(controller, animated: true, completion: nil)
          } else {
            ProgressHUD.showError("Please check your email and verify your registration")
          }
        } else {
          ProgressHUD.showError(error?.localizedDescription)
        }
      }
    } else {
      ProgressHUD.showError("All Fields Is Required")
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
    if isDataInputedFor(mode: "forgetPassword") {
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
    let controller = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
    controller.modalPresentationStyle = .fullScreen
    present(controller, animated: true)
  }
}
