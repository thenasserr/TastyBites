//
//  ProfileTableViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 29/12/2023.
//

import UIKit

class ProfileTableViewController: UITableViewController {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.tableFooterView = UIView()

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showUserInfo()
  }

  @IBAction func aboutButtonPressed(_ sender: Any) {
    let controller = AboutViewController.instantiate()
    controller.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(controller, animated: true)
  }

  @IBAction func logoutButtonPressed(_ sender: Any) {

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

  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = UIColor(named: "ColorTableView")
    return headerView
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return section == 0 ? 0.0: 10.0
  }

//  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    if indexPath.section == 2 && indexPath.row == 3 {
//      performSegue(withIdentifier: "AboutViewController", sender: self)
//    }
//  }

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





