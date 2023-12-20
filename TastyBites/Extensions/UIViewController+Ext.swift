//
//  UIViewController+Ext.swift
//  TastyBites
//
//  Created by Ibrahim Nasser Ibrahim on 21/12/2023.
//

import UIKit

extension UIViewController {
  static var identifier: String {
    return String(describing: self)
  }

  static func instantiate() -> Self {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
  }
}
