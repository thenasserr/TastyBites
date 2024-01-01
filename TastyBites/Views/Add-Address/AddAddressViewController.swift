//
//  AddAddressViewController.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 01/01/2024.
//

import UIKit
import ProgressHUD

//protocol BackWithAddress: AnyObject {
//  func back(address: [Address])
//}

class AddAddressViewController: UIViewController {

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var streetTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  @IBAction func addAddressPressed(_ sender: Any) {
    guard
        let name = nameTextField.text, !name.isEmpty,
        let city = cityTextField.text, !city.isEmpty,
        let address = streetTextField.text, !address.isEmpty,
        let phone = phoneTextField.text ,!phone.isEmpty
    else {
      ProgressHUD.showError("All fileds must be not empty")
        return
    }

    guard validatePhoneNumber(phone) else {
      ProgressHUD.showError("Invalid phone number")
        return
    }
    
    let controller = AddressViewController()
    self.navigationController?.pushViewController(controller, animated: true)



    func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,11}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let arrString = Array(phoneNumber)
        return arrString.count > 2 && phoneNumber.first == "0" && arrString[1] == "1" && phoneTest.evaluate(with: phone)
    }

  }
}
