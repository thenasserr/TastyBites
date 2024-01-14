//
//  AddAddressViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit
import ProgressHUD

protocol BackWithAddress: AnyObject {
  func back(address: [Address])
}

class AddAddressViewController: UIViewController {

  //MARK: - Vars
  weak var delegate: BackWithAddress?
  var data: [Address] = []

  //MARK: - IBOutlets
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var streetTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!

  override func viewDidLoad() {
      super.viewDidLoad()
      setupKeyboardDismissGesture()
  }

  private func setupKeyboardDismissGesture() {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
      tapGesture.cancelsTouchesInView = false
      view.addGestureRecognizer(tapGesture)
  }

  @objc private func dismissKeyboard() {
      view.endEditing(true)
  }

  @IBAction func addAddressPressed(_ sender: Any) {
    guard
      let name = nameTextField.text, !name.isEmpty,
      let city = cityTextField.text, !city.isEmpty,
      let address = streetTextField.text, !address.isEmpty,
      let phone = phoneTextField.text ,!phone.isEmpty
    else {
      showError(NSLocalizedString("All fields must not be empty", comment: ""))
      return
    }

    guard validatePhoneNumber(phone) else {
      showError(NSLocalizedString("Invalid phone number", comment: ""))
      return
    }

    // Assuming `data` is an array property
    data = [.init(name: name, city: city, street: address, phone: phone)]

    delegate?.back(address: data)
    navigationController?.popViewController(animated: true)
  }

  // Helper method to show an error using ProgressHUD
  private func showError(_ message: String) {
    ProgressHUD.showError(message)
  }

  // MARK: - Check the Validation of Phone Number
  func validatePhoneNumber(_ phoneNumber: String) -> Bool {
    let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,11}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    let arrString = Array(phoneNumber)
    return arrString.count > 2 && phoneNumber.first == "0" && arrString[1] == "1" && phoneTest.evaluate(with: phoneNumber)
  }

  deinit {
    print("AddAddressViewController Deallocated")
  }
}
