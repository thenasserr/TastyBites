//
//  SettingsViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit

class SettingsViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    configureTableView()
    self.tabBarController?.tabBar.isHidden = true

    }


  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: SettingsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SettingsTableViewCell.identifier)
  }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 4
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      switch indexPath.row{
      case 0:
          let cell =  tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
          cell.settingsLabel.text = "About US"
          cell.imgView.image = UIImage(systemName: "person.3.fill")
          return cell
      case 1:
        let cell =  tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
          cell.settingsLabel.text = "Contact US"
          cell.imgView.image = UIImage(systemName: "phone.and.waveform")
          return cell
      case 2:
          let cell =  tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
          cell.settingsLabel.text = "Address"
          cell.imgView.image = UIImage(systemName: "location.north.circle.fill")
          return cell
      case 3:
          let cell =  tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
          cell.settingsLabel.text = "Sign Out"
          cell.imgView.image = UIImage(systemName: "rectangle.portrait.and.arrow.forward.fill")
          return cell
      default:
          let cell =  tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
          cell.settingsLabel.text = "TastyBites"
          cell.imgView.image = UIImage(named: "appIcon")
          return cell
      }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 70
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      let controller = AboutViewController.instantiate()
      controller.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(controller, animated: true)
    case 1:
      let controller = ContactUsViewController()
      controller.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(controller, animated: true)
    case 2:
      let controller = AddressViewController()
      controller.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(controller, animated: true)
    case 3:
      FirebaseUserListener.shared.logOutUser { error in
        if error == nil {
          let loginView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
          DispatchQueue.main.async {
            loginView.modalPresentationStyle = .fullScreen
            self.present(loginView, animated: true)
          }
        }
      }
    default:
      print("Default")
    }
  }
}
