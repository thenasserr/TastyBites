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

  //MARK: - Setup TableView
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: SettingsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SettingsTableViewCell.identifier)
  }

}

//MARK: - TabelView Delegate and DataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table View Sections

    enum Section: Int {
        case aboutUs = 0
        case contactUs
        case address
        case signOut
        case appInfo
    }

    // MARK: - Table View Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.row) {
        case .aboutUs:
            return configureCell(for: indexPath, title: "About Us", imageName: "person.3.fill")
        case .contactUs:
            return configureCell(for: indexPath, title: "Contact Us", imageName: "phone.and.waveform")
        case .address:
            return configureCell(for: indexPath, title: "Address", imageName: "location.north.circle.fill")
        case .signOut:
            return configureCell(for: indexPath, title: "Sign Out", imageName: "rectangle.portrait.and.arrow.forward.fill")
        case .appInfo:
            return configureCell(for: indexPath, title: "TastyBites", imageName: "appIcon")
        case .none:
            return UITableViewCell()
        }
    }

    // MARK: - Table View Delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.row) {
        case .aboutUs:
            pushController(AboutViewController.instantiate())
        case .contactUs:
            pushController(ContactUsViewController())
        case .address:
            pushController(AddressViewController())
        case .signOut:
            signOutUser()
        case .appInfo:
            print("Default")
        case .none:
            break
        }
    }

    // MARK: - Helper Methods

    private func configureCell(for indexPath: IndexPath, title: String, imageName: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.settingsLabel.text = title
        cell.imgView.image = UIImage(systemName: imageName)
        return cell
    }

    private func pushController(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func signOutUser() {
        FirebaseUserListener.shared.logOutUser { [weak self] error in
            if error == nil {
                let loginView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                DispatchQueue.main.async {
                    loginView.modalPresentationStyle = .fullScreen
                    self?.present(loginView, animated: true)
                }
            }
        }
    }
}
