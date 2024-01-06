//
//  ProfileViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 31/12/2023.
//

import UIKit

class ProfileViewController: UIViewController {

  @IBOutlet weak var tabelView: UITableView!
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  var titles: [String] = ["My Orders", "Wish List"]
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    self.tabBarController?.tabBar.isHidden = false

    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.tabBarController?.tabBar.isHidden = false
    showUserInfo()
  }



  @IBAction func signoutPressed(_ sender: Any) {

    FirebaseUserListener.shared.logOutUser { error in
      if error == nil {
        let loginView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        DispatchQueue.main.async {
          loginView.modalPresentationStyle = .fullScreen
          self.present(loginView, animated: true)
        }
      }
    }
  }

  @IBAction func aboutButtonPressed(_ sender: Any) {
    let controller = AboutViewController.instantiate()
    controller.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(controller, animated: true)
  }
  

  private func showUserInfo() {
    if let user = UserModel.currentUser {
      nameLabel.text = user.name

    }

  }

  
  @IBAction func settingsPressed(_ sender: Any) {
    let controller = SettingsViewController.instantiate()
    navigationController?.pushViewController(controller, animated: true)
  }
  
}


