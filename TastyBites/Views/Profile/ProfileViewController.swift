//
//  ProfileViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 31/12/2023.
//

import UIKit

class ProfileViewController: UIViewController {

  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    userImage.image = UIImage(named: "ava")?.circleMasked

    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
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
    if let user = User.currentUser {
      nameLabel.text = user.name
      emailLabel.text = user.email

      //      if user.avataLink != nil {
      //TODO:- Download Image
      //        FileStroage.downloadImage(imageURL: user.avataLink) { avatarImage in
      //          self.avatarImageView.image = avatarImage?.circleMasked
    }

  }

}
