//
//  AddressViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit

class AddressViewController: UIViewController {


//MARK: - Vars
  var address: [Address] = [] {
    didSet {
      saveAddress()
    }
  }

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    configreTableView()
    SetupAddButoon()
    getAddress()

  }

  override func viewWillAppear(_ animated: Bool) {
    tableView.reloadData()
    print(address)
  }


  //MARK: - Setup TableView
  private func configreTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: AddressTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AddressTableViewCell.identifier)
  }


  //MARK: - Setup Bar Button Item
  func SetupAddButoon(){
    let add = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action:#selector(AddAdress))
    navigationItem.rightBarButtonItem = add
    navigationItem.rightBarButtonItem?.tintColor = UIColor.black
  }


  //MARK: - setup the naviagton of add button
  @objc func AddAdress(){
    let controller = AddAddressViewController()
    controller.delegate = self
    self.navigationController?.pushViewController(controller, animated: true)
  }

  //MARK: - Save Address Locally
  func saveAddress() {
    if let encodedData = try? JSONEncoder().encode(address) {
      UserDefaults.standard.set(encodedData, forKey: "address")
    }
  }
  
  //MARK: - Get Address
  func getAddress() {
    guard
      let data = UserDefaults.standard.data(forKey: "address"),
      let savedItems = try? JSONDecoder().decode([Address].self, from: data)
    else { return }

    self.address = savedItems
  }
}

//MARK: - TabelView Delegate and DataSource
extension AddressViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return address.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath) as! AddressTableViewCell
    if address.count == 0 {
      return UITableViewCell()
    } else {
      cell.nameLabel.text = address[indexPath.row].name ?? ""
      cell.cityLabel.text = address[indexPath.row].city ?? ""
      cell.streetLabel.text = address[indexPath.row].street ?? ""
      return cell
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }

}

//MARK: - Data retrived from AddAddressViewController
extension AddressViewController: BackWithAddress {
  func back(address: [Address]) {
    self.address = address
  }
}

