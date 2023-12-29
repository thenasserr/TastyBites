//
//  LoginViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 22/12/2023.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    
    }

  @IBAction func loginButtonPressed(_ sender: Any) {
  }
  
  @IBAction func signupButtonPressed(_ sender: Any) {
    let controller = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
    controller.modalPresentationStyle = .fullScreen
    present(controller, animated: true)
  }
}
