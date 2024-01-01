//
//  SignUpViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//

import UIKit
import ProgressHUD

class SignUpViewController: UIViewController {

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
  //MARK: - Creat Account
  @IBAction func creatAccountButtonPressed(_ sender: Any) {
    guard let name = nameTextField.text,
          let email = emailTextField.text,
          let password = passwordTextField.text else {
      return
    }
    if isDataInputedFor() {
      FirebaseUserListener.shared.registerNewUser(email: email, password: password, name: name) { error in
        if error == nil {
          ProgressHUD.showSuccess("Email Verification Sent, Please Verifiy Your Email")
        } else {
          ProgressHUD.showError(error?.localizedDescription)
        }
      }
    } else {
      ProgressHUD.showError("All Fields Is Required")
    }

  }

  //MARK: - Check Validation
  private func isDataInputedFor() -> Bool {
    return nameTextField.text != "" && passwordTextField.text != "" && emailTextField.text != ""
  }


  @IBAction func signinButtonPressed(_ sender: Any) {
    let controller = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    controller.modalPresentationStyle = .fullScreen
    present(controller, animated: true)
  }
}
