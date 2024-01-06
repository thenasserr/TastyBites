//
//  ContactUsViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit

class ContactUsViewController: UIViewController {

  //MARK: - Vars
  var owner: [ContactUs] = []

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    owner = [
      .init(image: UIImage(named: "ava")!, name: "Ibrahim Nasser", email: "thenasserr@gmail.com", number: "01553422032")
    ]

    configreTableView()
  }

  //MARK: - Setup TableView
  private func configreTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: ContactUsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ContactUsTableViewCell.identifier)
  }

}

//MARK: - TabelView Delegate and DataSource
extension ContactUsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return owner.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ContactUsTableViewCell.identifier, for: indexPath) as! ContactUsTableViewCell
    cell.setup(owner: owner[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
}
