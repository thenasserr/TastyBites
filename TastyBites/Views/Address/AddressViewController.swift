//
//  AddressViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit

class AddressViewController: UIViewController {

  var address: [Address] = []

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    configreTableView()
    SetupAddButoon()
    }

  private func configreTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: AddressTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AddressTableViewCell.identifier)
  }

  func SetupAddButoon(){
      let add = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action:#selector(AddAdress))
      navigationItem.rightBarButtonItem = add
      navigationItem.rightBarButtonItem?.tintColor = UIColor.black
  }
  //setup the naviagton of add button
  @objc func AddAdress(){
      self.navigationController?.pushViewController(AddAddressViewController(), animated: true)
  }
}

extension AddressViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath) as! AddressTableViewCell
    cell.nameLabel.text = "Ibrahim Nasser"
    cell.cityLabel.text = "Mansoura"
    cell.streetLabel.text = "El Gish St"
    return cell
  }



  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

