//
//  GettingStartedViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 28/12/2023.
//

import UIKit

class GettingStartedViewController: UIViewController {

  @IBOutlet weak var signupButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

  @IBAction func signinButtonPressed(_ sender: Any) {
    let controller = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    controller.modalPresentationStyle = .fullScreen
    present(controller, animated: true)
  }


  @IBAction func signupButtonPressed(_ sender: Any) {
    let controller = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
    controller.modalPresentationStyle = .fullScreen
    present(controller, animated: true)
  }
}
